#!/usr/bin/env bash
input=$(cat)

echo "$input" | node -e "
const {execSync} = require('child_process');
process.stdin.setEncoding('utf8');
let d='';
process.stdin.on('data',c=>d+=c);
process.stdin.on('end',()=>{
  try {
    const o = JSON.parse(d);

    const R      = '\x1b[0m';
    const SEP    = '\x1b[38;5;238m \xb7 ' + R;
    const CYAN   = '\x1b[38;5;87m';
    const BGREEN = '\x1b[38;5;120m';
    const MODEL  = '\x1b[38;5;183m';

    // ctx: cyan → blue → orange → red
    function ctxColor(pct) {
      if (pct < 40) return '\x1b[38;5;87m';
      if (pct < 60) return '\x1b[38;5;75m';
      if (pct < 75) return '\x1b[38;5;69m';
      if (pct < 88) return '\x1b[38;5;208m';
      return '\x1b[38;5;196m';
    }
    // 5h: lavender → purple → magenta → red
    function fhColor(pct) {
      if (pct < 40) return '\x1b[38;5;183m';
      if (pct < 60) return '\x1b[38;5;177m';
      if (pct < 75) return '\x1b[38;5;171m';
      if (pct < 88) return '\x1b[38;5;207m';
      return '\x1b[38;5;196m';
    }
    // 7d: yellow → amber → orange → red
    function wdColor(pct) {
      if (pct < 40) return '\x1b[38;5;190m';
      if (pct < 60) return '\x1b[38;5;226m';
      if (pct < 75) return '\x1b[38;5;220m';
      if (pct < 88) return '\x1b[38;5;208m';
      return '\x1b[38;5;196m';
    }

    // Folder name (last segment of cwd)
    const cwd    = o.cwd || '';
    const folder = cwd.replace(/\\\\/g,'/').split('/').filter(Boolean).pop() || cwd;

    // Branch via git
    let branch = '';
    if (cwd) {
      try {
        branch = execSync(
          'git --no-optional-locks -C \"' + cwd + '\" symbolic-ref --short HEAD 2>nul',
          {encoding:'utf8', stdio:['pipe','pipe','pipe']}
        ).trim();
      } catch(e) {
        try {
          branch = execSync(
            'git --no-optional-locks -C \"' + cwd + '\" rev-parse --short HEAD 2>nul',
            {encoding:'utf8', stdio:['pipe','pipe','pipe']}
          ).trim();
        } catch(e2) {}
      }
    }

    // Model label — o.model is an object {id, display_name}
    const label = (o.model && (o.model.display_name || o.model.id)) || '';

    // Context window
    const ctxPct  = (o.context_window && o.context_window.used_percentage)    || 0;
    const ctxUsed = (o.context_window && o.context_window.total_input_tokens)  || 0;
    const ctxMax  = (o.context_window && o.context_window.context_window_size) || 0;

    function fmtK(n) {
      if (n >= 1000000) return (n / 1000000).toFixed(1).replace(/\.0$/, '') + 'M';
      if (n >= 1000)    return Math.round(n / 1000) + 'k';
      return String(n);
    }

    // Rate limits
    const rl  = o.rate_limits || {};
    const fh  = rl.five_hour  || rl['5h'] || {};
    const wd  = rl.seven_day  || rl['7d'] || rl.weekly || {};

    // resets_at is Unix seconds
    function timeRemaining(ts) {
      if (!ts) return '';
      const diff = ts * 1000 - Date.now();
      if (diff <= 0) return '0 min';
      const totalMin = Math.floor(diff / 60000);
      const hr  = Math.floor(totalMin / 60);
      const min = totalMin % 60;
      return hr > 0 ? hr + ' hr ' + min + ' min' : min + ' min';
    }

    function bishkekDate(ts) {
      if (!ts) return '';
      try {
        const d = new Date(ts * 1000);
        const day     = new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Bishkek', day: 'numeric' }).format(d);
        const month   = new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Bishkek', month: 'long' }).format(d);
        const time    = new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Bishkek', hour: '2-digit', minute: '2-digit', hour12: false }).format(d);
        const weekday = new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Bishkek', weekday: 'long' }).format(d);
        return day + ' ' + month + ', ' + time + ', ' + weekday;
      } catch(e) { return ''; }
    }

    const line1 = [];
    const line2 = [];

    if (folder) line1.push(CYAN   + folder + R);
    if (branch) line1.push(BGREEN + branch + R);
    if (label)  line2.push(MODEL  + label  + R);

    if (ctxPct > 0) {
      const tokens = ctxUsed && ctxMax ? ' ' + fmtK(ctxUsed) + '/' + fmtK(ctxMax) : '';
      line2.push(ctxColor(ctxPct) + 'ctx: ' + ctxPct + '%' + tokens + R);
    }

    const fhPct = fh.used_percentage || 0;
    if (fhPct > 0) {
      const remaining = timeRemaining(fh.resets_at);
      const txt = '5h: ' + fhPct + '%' + (remaining ? ' - ' + remaining : '');
      line2.push(fhColor(fhPct) + txt + R);
    }

    const wdPct = wd.used_percentage || 0;
    if (wdPct > 0) {
      const reset = bishkekDate(wd.resets_at);
      const txt   = '7d: ' + wdPct + '%' + (reset ? ' - ' + reset : '');
      line2.push(wdColor(wdPct) + txt + R);
    }

    const out = [line1, line2]
      .filter(l => l.length > 0)
      .map(l => l.join(SEP))
      .join('\n');
    process.stdout.write(out + '\n');
  } catch(e) {
    process.stdout.write('');
  }
});" 2>/dev/null
