<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>ReinosBioGame · 1º ESO (Single File)</title>
  <style>

:root{
  --b: #0c1116;
  --bg1: #f2fbff;
  --bg2: #ecfff6;
  --br: #dfe7ef;
  --ok: #12b886;
  --err: #ff6b6b;
}
*{box-sizing:border-box}
body{margin:0;font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Helvetica,Arial,sans-serif;color:#1f2937;background:linear-gradient(180deg,var(--bg1),var(--bg2));}
.app{max-width:1200px;margin:0 auto;padding:16px}
.topbar{display:flex;gap:12px;align-items:center;justify-content:space-between;background:rgba(255,255,255,.8);padding:10px 12px;border-radius:16px;box-shadow:0 2px 10px rgba(0,0,0,.05)}
.brand{display:flex;align-items:center;gap:8px}
.brand .emoji{font-size:24px}
.actions{display:flex;gap:8px}
.btn{border:1px solid var(--br);background:#fff;padding:8px 12px;border-radius:10px;cursor:pointer}
.btn.small{padding:6px 10px;font-size:12px}
.btn:hover{background:#f8fafc}
.panel{border:1px solid var(--br);border-radius:16px;background:rgba(255,255,255,.75);padding:12px}
.panel-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:8px}
.help{margin-top:12px}
.help-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:8px}
.help-card{border:1px solid var(--br);border-radius:12px;padding:8px}
.help-name{font-weight:600;font-size:14px}
.help-desc{opacity:.8;font-size:12px}
.grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px;margin-top:12px}
.stats{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;margin:8px 0}
.stat{border:1px solid var(--br);border-radius:12px;background:rgba(255,255,255,.7);padding:8px;text-align:center}
.label{font-size:11px;opacity:.6}
.value{font-weight:700}
.progress{height:8px;background:#e5e7eb;border-radius:999px;overflow:hidden}
.bar{height:8px;background:#10b981}
.hint{font-size:12px;opacity:.8}
.chips{display:flex;flex-wrap:wrap;gap:6px}
.chip{border:1px solid var(--br);border-radius:999px;padding:4px 10px;font-size:12px;background:#f8fafc}
.chip.ok{background:#dcfce7;border-color:#bbf7d0}
.cards{display:grid;grid-template-columns:1fr 1fr;gap:8px}
.card-item{display:flex;align-items:center;justify-content:space-between;gap:8px;border:1px solid var(--br);border-radius:12px;background:#fff;padding:10px;cursor:grab}
.card-item .meta{display:flex;align-items:center;gap:10px}
.card-item .emoji{font-size:22px}
.badge{border:1px solid var(--br);border-radius:999px;padding:2px 8px;font-size:12px;opacity:.7}
.zones{display:grid;grid-template-columns:1fr 1fr;gap:8px}
.zone{min-height:120px;border:2px dashed #cbd5e1;border-radius:14px;padding:8px;transition:box-shadow .15s, border-color .15s}
.zone.ok{box-shadow:0 0 0 4px rgba(16,185,129,.4);border-color:#86efac}
.zone.err{box-shadow:0 0 0 4px rgba(244,63,94,.3);border-color:#fda4af}
.footer{border:1px solid var(--br);border-radius:16px;background:rgba(255,255,255,.6);padding:12px;margin-top:10px;font-size:14px}
.row{display:flex;gap:8px;flex-wrap:wrap}
.left,.center,.right{display:flex;flex-direction:column;gap:12px}
.hidden{display:none}
.modal{position:fixed;inset:0;display:grid;place-items:center;background:rgba(0,0,0,.4)}
.modal.hidden{display:none}
.modal-content{max-width:680px;width:90%;background:#fff;border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,.2);padding:14px}
.modal-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:8px}
@media (max-width:980px){.grid{grid-template-columns:1fr}.cards{grid-template-columns:1fr} .help-grid{grid-template-columns:1fr 1fr} .zones{grid-template-columns:1fr} }

  </style>
</head>
<body>
  <div class="app">
    <header class="topbar">
      <div class="brand">
        <span class="emoji">🧬</span>
        <h1>ReinosBioGame · 1º ESO (Single File)</h1>
      </div>
      <div class="actions">
        <button id="btnDocente" class="btn">Panel docente</button>
        <button id="btnReset" class="btn">Reiniciar</button>
        <button id="btnExport" class="btn">Exportar CSV</button>
      </div>
    </header>

    <section id="panelDocente" class="panel hidden">
      <h2>Panel docente</h2>
      <ul>
        <li><b>Objetivo:</b> Clasificar seres vivos en Moneras, Protoctistas, Hongos, Plantas y Animales.</li>
        <li><b>Modos:</b> Práctica (sin tiempo) y Reto (con cuenta atrás).</li>
        <li><b>Evaluación formativa:</b> rachas, aciertos, porcentaje y tiempo.</li>
        <li><b>Accesibilidad:</b> también se puede hacer clic en las tarjetas.</li>
      </ul>
    </section>

    <section class="help">
      <h3>Recordatorio rápido de los 5 reinos</h3>
      <div id="reinosAyuda" class="help-grid"></div>
    </section>

    <section class="grid">
      <aside class="left">
        <div class="card panel">
          <div class="panel-head">
            <strong>Controles</strong>
            <div class="row">
              <button id="btnModo" class="btn small">Cambiar a Reto</button>
              <button id="btnScoreboard" class="btn small">Tablero clase</button>
            </div>
          </div>
          <div class="stats">
            <div class="stat"><div class="label">Nivel</div><div class="value" id="nivelNombre">—</div></div>
            <div class="stat"><div class="label">Modo</div><div class="value" id="modoNombre">Práctica</div></div>
            <div class="stat"><div class="label">Puntos</div><div class="value" id="puntos">0</div></div>
            <div class="stat"><div class="label">Aciertos</div><div class="value"><span id="aciertos">0</span>/<span id="total">0</span></div></div>
            <div class="stat"><div class="label">Racha</div><div class="value" id="racha">0</div></div>
            <div class="stat"><div class="label" id="labelTiempoOPistas">Pistas</div><div class="value" id="tiempoOPistas">3</div></div>
          </div>
          <div class="progress"><div class="bar" id="progressBar" style="width:0%"></div></div>
          <p class="hint">Consejo: haz clic en una tarjeta para una pista (–30 pts). Máx. 3 por nivel.</p>
        </div>

        <div class="card panel">
          <div class="panel-head"><strong>Logros</strong></div>
          <div id="logros" class="chips"></div>
        </div>

        <div class="card panel">
          <div class="panel-head"><strong>Acciones de nivel</strong></div>
          <div class="row">
            <button id="btnRepetir" class="btn">Repetir nivel</button>
            <button id="btnSiguiente" class="btn">Siguiente nivel</button>
          </div>
        </div>
      </aside>

      <main class="center">
        <div class="card panel">
          <div class="panel-head">
            <strong>Tarjetas activas (<span id="restantes">0</span> restantes)</strong>
            <button id="btnBarajar" class="btn small">Barajar visibles</button>
          </div>
          <div id="tarjetas" class="cards"></div>
        </div>
      </main>

      <aside class="right">
        <div class="card panel">
          <div class="panel-head"><strong>Suelta aquí según el reino</strong></div>
          <div id="zonas" class="zones"></div>
        </div>
      </aside>
    </section>

    <footer class="footer">
      <strong>Cómo se juega</strong>
      <ol>
        <li>Lee el recordatorio de los 5 reinos.</li>
        <li>Arrastra cada tarjeta a su reino o haz clic para pista (–30 pts).</li>
        <li>En modo Reto, vigila el tiempo. Las rachas suman puntos extra.</li>
        <li>Completa el nivel para guardar el resultado en el dispositivo.</li>
      </ol>
    </footer>
  </div>

  <div id="modal" class="modal hidden">
    <div class="modal-content">
      <div class="modal-head">
        <h3>Información</h3>
        <button id="modalClose" class="btn small">Cerrar</button>
      </div>
      <div id="modalBody"></div>
    </div>
  </div>

  <script>

/** ReinosBioGame Offline – Vanilla JS (sin dependencias, 3 ficheros) **/
(function(){
  // Datos base
  const REINOS = [
    { id:'moneras', nombre:'Moneras', ayuda:'Procariotas: bacterias. Sin núcleo verdadero.' },
    { id:'protoctistas', nombre:'Protoctistas', ayuda:'Eucariotas sencillos: algas y protozoos.' },
    { id:'hongos', nombre:'Hongos', ayuda:'Heterótrofos por absorción: mohos, levaduras, setas.' },
    { id:'plantas', nombre:'Plantas', ayuda:'Autótrofos: realizan fotosíntesis.' },
    { id:'animales', nombre:'Animales', ayuda:'Heterótrofos por ingestión: invertebrados y vertebrados.' },
  ];
  const TARJETAS_BASE = [
    { nombre:'Escherichia coli', emoji:'🦠', reino:'moneras' },
    { nombre:'Streptococcus', emoji:'🧫', reino:'moneras' },
    { nombre:'Cianobacteria', emoji:'💧', reino:'moneras' },
    { nombre:'Ameba', emoji:'🧪', reino:'protoctistas' },
    { nombre:'Paramecio', emoji:'🔬', reino:'protoctistas' },
    { nombre:'Alga verde (Chlorella)', emoji:'🟢', reino:'protoctistas' },
    { nombre:'Levadura', emoji:'🍞', reino:'hongos' },
    { nombre:'Moho (Penicillium)', emoji:'🧀', reino:'hongos' },
    { nombre:'Seta (Agaricus)', emoji:'🍄', reino:'hongos' },
    { nombre:'Musgo', emoji:'🌿', reino:'plantas' },
    { nombre:'Helecho', emoji:'🌱', reino:'plantas' },
    { nombre:'Pino', emoji:'🌲', reino:'plantas' },
    { nombre:'Rosa', emoji:'🌹', reino:'plantas' },
    { nombre:'Oruga', emoji:'🐛', reino:'animales' },
    { nombre:'Mariposa', emoji:'🦋', reino:'animales' },
    { nombre:'Medusa', emoji:'🎐', reino:'animales' },
    { nombre:'Sardina', emoji:'🐟', reino:'animales' },
    { nombre:'Lagartija', emoji:'🦎', reino:'animales' },
    { nombre:'Gorrión', emoji:'🐦', reino:'animales' },
    { nombre:'Humano', emoji:'🧍', reino:'animales' },
    { nombre:'Euglena', emoji:'🧫', reino:'protoctistas' },
    { nombre:'Alga parda (Laminaria)', emoji:'🟤', reino:'protoctistas' },
    { nombre:'Agar-agar (alga roja)', emoji:'🔴', reino:'protoctistas' },
    { nombre:'Trufa', emoji:'⚫️', reino:'hongos' },
    { nombre:'Líquenes', emoji:'🪨', reino:'hongos' },
    { nombre:'Lenteja de agua', emoji:'🪷', reino:'plantas' },
    { nombre:'Cactus', emoji:'🌵', reino:'plantas' },
    { nombre:'Estrella de mar', emoji:'⭐️', reino:'animales' },
    { nombre:'Pulga de agua (Daphnia)', emoji:'💧', reino:'animales' },
    { nombre:'Anémona', emoji:'🌸', reino:'animales' },
  ];
  const NIVELES = [
    { id:1, nombre:'Nivel 1 • ¡Calentamos motores!', n:10, tiempo:120 },
    { id:2, nombre:'Nivel 2 • Subimos el reto', n:16, tiempo:120 },
    { id:3, nombre:'Nivel 3 • Pro total', n:22, tiempo:150 },
  ];
  const LOGROS = [
    { id:'primer_acierto', nombre:'Primer acierto' },
    { id:'racha_5', nombre:'Racha 5' },
    { id:'nivel_superado', nombre:'Supera un nivel' },
    { id:'sin_pistas', nombre:'A pelo' },
  ];
  const PISTAS_POR_NIVEL = 3;

  // Estado
  let modoReto = false;
  let nivelIdx = 0;
  let objetivo = [];
  let pila = [];
  let puntuacion = 0;
  let aciertos = 0;
  let racha = 0;
  let usadosPistas = 0;
  let tiempoRestante = NIVELES[0].tiempo;
  let timerId = null;
  let ultimaRespuesta = null;
  let logros = new Set();

  // Utilidades
  const $ = (sel)=>document.querySelector(sel);
  const $$ = (sel)=>Array.from(document.querySelectorAll(sel));
  const shuffle = (arr)=>arr.map(v=>[Math.random(),v]).sort((a,b)=>a[0]-b[0]).map(([,v])=>v);
  const formatTime = (t)=>{
    const m = String(Math.floor(t/60)).padStart(2,'0');
    const s = String(t%60).padStart(2,'0');
    return `${m}:${s}`;
  };
  const setText = (sel, val)=>{ const el=$(sel); if (el) el.textContent = val; };

  function renderAyuda(){
    const cont = $("#reinosAyuda");
    cont.innerHTML = "";
    REINOS.forEach(r=>{
      const d = document.createElement('div');
      d.className = "help-card";
      d.innerHTML = `<div class="help-name">${r.nombre}</div><div class="help-desc">${r.ayuda}</div>`;
      cont.appendChild(d);
    });
  }

  function prepararNivel(idx){
    const nv = NIVELES[idx];
    const baraja = shuffle(TARJETAS_BASE.slice());
    objetivo = baraja.slice(0, nv.n);
    pila = objetivo.slice();
    puntuacion = 0; aciertos = 0; racha = 0; usadosPistas = 0; ultimaRespuesta = null;
    tiempoRestante = nv.tiempo;
    if (timerId){ clearInterval(timerId); timerId = null; }
    if (modoReto){
      timerId = setInterval(()=>{
        tiempoRestante--;
        if (tiempoRestante <= 0){ tiempoRestante = 0; clearInterval(timerId); timerId = null; pila = []; }
        actualizarUI();
        if (pila.length === 0) finDeNivel();
      }, 1000);
    }
    actualizarUI();
    renderTarjetas();
    renderZonas();
  }

  function actualizarUI(){
    const nv = NIVELES[nivelIdx];
    setText("#nivelNombre", nv.nombre);
    setText("#modoNombre", modoReto ? "Reto" : "Práctica");
    setText("#puntos", String(puntuacion));
    setText("#aciertos", String(aciertos));
    setText("#total", String(objetivo.length));
    setText("#racha", String(racha));
    $("#labelTiempoOPistas").textContent = modoReto ? "Tiempo" : "Pistas";
    $("#tiempoOPistas").textContent = modoReto ? formatTime(tiempoRestante) : String(PISTAS_POR_NIVEL - usadosPistas);
    $("#restantes").textContent = String(pila.length);
    const porcentaje = objetivo.length? Math.round((aciertos/objetivo.length)*100):0;
    $("#progressBar").style.width = `${porcentaje}%`;
    renderLogros();
  }

  function renderLogros(){
    const cont = $("#logros");
    cont.innerHTML = "";
    LOGROS.forEach(l=>{
      const span = document.createElement('span');
      span.className = "chip " + (logros.has(l.id) ? "ok" : "");
      span.textContent = (logros.has(l.id) ? "🏅 " : "🔒 ") + l.nombre;
      cont.appendChild(span);
    });
  }

  function renderTarjetas(){
    const cont = $("#tarjetas");
    cont.innerHTML = "";
    const visibles = pila.slice(0,6);
    if (visibles.length === 0){
      const dd = document.createElement('div');
      dd.className = "card-item";
      dd.textContent = "No hay tarjetas activas. Repite o avanza de nivel.";
      cont.appendChild(dd);
      return;
    }
    visibles.forEach(item=>{
      const el = document.createElement('div');
      el.className = "card-item";
      el.draggable = true;
      el.addEventListener('dragstart', e=>{
        e.dataTransfer.setData('text/plain', JSON.stringify(item));
      });
      el.addEventListener('click', ()=>usarPista(item));
      el.innerHTML = `<div class="meta"><span class="emoji">${item.emoji}</span><div><div class="name">${item.nombre}</div><div class="help small">Haz clic para pista · arrastra para clasificar</div></div></div><span class="badge">mover</span>`;
      cont.appendChild(el);
    });
  }

  function renderZonas(){
    const cont = $("#zonas");
    cont.innerHTML = "";
    REINOS.forEach(r=>{
      const z = document.createElement('div');
      z.className = "zone";
      z.innerHTML = `<div class="help-name">${r.nombre}</div><div class="help-desc">${r.ayuda}</div>`;
      z.addEventListener('dragover', e=>e.preventDefault());
      z.addEventListener('drop', e=>{
        e.preventDefault();
        const payload = e.dataTransfer.getData('text/plain');
        if (payload){
          const item = JSON.parse(payload);
          onDropItem(item, r.id, z);
        }
      });
      cont.appendChild(z);
    });
  }

  function onDropItem(item, destinoId, zonaEl){
    const ok = item.reino === destinoId;
    ultimaRespuesta = { item, destino: destinoId, ok };
    // Quitamos de pila (si estaba)
    const idx = pila.findIndex(x => x.nombre === item.nombre && x.reino === item.reino);
    if (idx >= 0) pila.splice(idx,1);

    if (ok){
      aciertos++;
      racha++;
      if (racha === 1) logros.add('primer_acierto');
      if (racha === 5) logros.add('racha_5');
      puntuacion += 100 + (Math.max(0, racha-1) * 10);
      zonaEl.classList.add('ok'); setTimeout(()=>zonaEl.classList.remove('ok'), 350);
    }else{
      racha = 0;
      puntuacion = Math.max(0, puntuacion - 25);
      // Reinsertar aleatoriamente
      pila = shuffle([item, ...pila]);
      zonaEl.classList.add('err'); setTimeout(()=>zonaEl.classList.remove('err'), 350);
    }
    actualizarUI();
    renderTarjetas();
    if (pila.length === 0) finDeNivel();
  }

  function usarPista(item){
    if (modoReto) {
      // En reto permitimos pistas también
    }
    if (usadosPistas >= PISTAS_POR_NIVEL) return;
    usadosPistas++;
    puntuacion = Math.max(0, puntuacion - 30);
    alert(
      `Pista para "${item.nombre}":\n\n• Observa su forma de nutrición.\n• ¿Tiene núcleo? ¿Hace fotosíntesis?\n• Revisa el recordatorio de reinos.`
    );
    actualizarUI();
  }

  function finDeNivel(){
    if (timerId){ clearInterval(timerId); timerId = null; }
    const nv = NIVELES[nivelIdx];
    if (aciertos === objetivo.length && usadosPistas === 0) logros.add('sin_pistas');
    logros.add('nivel_superado');
    guardarResultado({
      nivel: nv.id,
      aciertos,
      total: objetivo.length,
      puntuacion,
      modoReto,
      tiempoUsado: modoReto ? (nv.tiempo - tiempoRestante) : null,
      pistas: usadosPistas,
      fecha: new Date().toISOString()
    });
    modal(`¡Nivel completado!<br><br>
      <b>Aciertos:</b> ${aciertos}/${objetivo.length}<br>
      <b>Puntuación:</b> ${puntuacion} pts<br>
      <b>Modo:</b> ${modoReto ? 'Reto' : 'Práctica'} ${modoReto ? `· Tiempo usado: ${formatTime(NIVELES[nivelIdx].tiempo - tiempoRestante)}` : ''}
    `);
  }

  function guardarResultado(registro){
    const key = 'reinos_biogame_resultados_offline';
    const prev = JSON.parse(localStorage.getItem(key) || '[]');
    prev.push(registro);
    localStorage.setItem(key, JSON.stringify(prev));
  }

  function exportarCSV(){
    const key = 'reinos_biogame_resultados_offline';
    const data = JSON.parse(localStorage.getItem(key) || '[]');
    const header = ['fecha','nivel','aciertos','total','puntuacion','modoReto','tiempoUsado','pistas'];
    const rows = data.map(r=>[r.fecha,r.nivel,r.aciertos,r.total,r.puntuacion,r.modoReto,r.tiempoUsado??'',r.pistas]);
    const csv = [header.join(','), ...rows.map(r=>r.join(','))].join('\n');
    downloadText('resultados_reinos_biogame_offline.csv', csv);
  }

  function downloadText(filename, text){
    const a = document.createElement('a');
    a.href = 'data:text/plain;charset=utf-8,' + encodeURIComponent(text);
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  }

  function modal(html){
    const m = $("#modal");
    $("#modalBody").innerHTML = html;
    m.classList.remove('hidden');
  }
  function closeModal(){ $("#modal").classList.add('hidden'); }

  // Eventos UI
  $("#btnDocente").addEventListener('click', ()=>{
    $("#panelDocente").classList.toggle('hidden');
  });
  $("#btnReset").addEventListener('click', ()=>{
    prepararNivel(nivelIdx);
  });
  $("#btnExport").addEventListener('click', exportarCSV);
  $("#btnModo").addEventListener('click', ()=>{
    modoReto = !modoReto;
    $("#btnModo").textContent = modoReto ? "Cambiar a Práctica" : "Cambiar a Reto";
    prepararNivel(nivelIdx);
  });
  $("#btnScoreboard").addEventListener('click', ()=>{
    const key = 'reinos_biogame_resultados_offline';
    const data = JSON.parse(localStorage.getItem(key) || '[]');
    if (!data.length){ alert('No hay resultados guardados aún.'); return; }
    alert('Resultados (últimos 5):\n' + data.slice(-5).map(d=>`• ${new Date(d.fecha).toLocaleString()} · Nivel ${d.nivel} · ${d.aciertos}/${d.total} · ${d.puntuacion} pts`).join('\n'));
  });
  $("#btnRepetir").addEventListener('click', ()=>prepararNivel(nivelIdx));
  $("#btnSiguiente").addEventListener('click', ()=>{
    nivelIdx = Math.min(NIVELES.length-1, nivelIdx+1);
    prepararNivel(nivelIdx);
  });
  $("#btnBarajar").addEventListener('click', ()=>{
    pila = shuffle(pila);
    renderTarjetas();
  });
  $("#modalClose").addEventListener('click', closeModal);
  $("#modal").addEventListener('click', e=>{ if (e.target.id === 'modal') closeModal(); });

  // Init
  renderAyuda();
  prepararNivel(0);
})();

  </script>
</body>
</html>
