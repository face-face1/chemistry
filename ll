<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>我的书库（GitHub Pages 预览）</title>
  <style>
    body{font-family:system-ui,Arial,Helvetica,sans-serif;max-width:1100px;margin:1.2rem auto;padding:0 1rem;color:#111}
    header{border-bottom:1px solid #eee;padding-bottom:0.6rem;margin-bottom:1rem}
    h1{margin:0}
    #sidebar{margin:0 0 1rem 0}
    .btn{display:inline-block;margin:.25rem .5rem .25rem 0;padding:.45rem .7rem;background:#0366d6;color:#fff;border-radius:6px;border:0;cursor:pointer}
    .btn:active{transform:translateY(1px)}
    iframe{width:100%;height:72vh;border:1px solid #ddd;border-radius:6px}
    #epubReader{width:100%;height:72vh;border:1px solid #ddd;border-radius:6px;overflow:auto}
    ul{padding-left:1rem}
    footer{margin-top:1rem;padding-top:1rem;border-top:1px solid #eee;color:#666;font-size:0.9rem}
    .note{background:#f8f9fb;border-left:4px solid #dfe7f5;padding:.6rem;margin:.6rem 0;border-radius:4px}
  </style>
</head>
<body>
  <header>
    <h1>我的书库</h1>
    <p>在下方上传书籍到 <code>books/</code> 目录，然后点击对应“预览”按钮查看内容（PDF/EPUB）。</p>
  </header>

  <div id="sidebar">
    <div class="note">
      默认示例按钮指向仓库内的文件：<code>books/book1.pdf</code> 和 <code>books/book2.epub</code>。把你自己的文件放进 <code>books/</code> 并修改按钮对应路径即可。
    </div>

    <!-- 修改这两行以指向你的实际文件 -->
    <button class="btn" onclick="showPDF('books/book1.pdf')">预览 PDF：book1.pdf</button>
    <button class="btn" onclick="showEPUB('books/book2.epub')">预览 EPUB：book2.epub</button>
  </div>

  <main id="viewer">
    <!-- PDF 用 iframe 简单嵌入 -->
    <iframe id="pdfFrame" style="display:none" title="PDF 预览"></iframe>

    <!-- EPUB 用 epub.js 渲染 -->
    <div id="epubReader" style="display:none"></div>
  </main>

  <footer>
    <p>说明：GitHub 单文件上传限制约 100 MB。若文件过大，请参见 README 的“文件过大时的替代方案”。</p>
    <p>© 2026 face-face1</p>
  </footer>

  <!-- epub.js（用于 EPUB 渲染） -->
  <script src="https://cdn.jsdelivr.net/npm/epubjs/dist/epub.min.js"></script>
  <script>
    const pdfFrame = document.getElementById('pdfFrame');
    const epubReader = document.getElementById('epubReader');
    let book, rendition;

    function hideAll() {
      pdfFrame.style.display = 'none';
      epubReader.style.display = 'none';
      if (rendition) {
        try { rendition.destroy(); } catch(e){}
        rendition = null;
        book = null;
        epubReader.innerHTML = '';
      }
    }

    function showPDF(url) {
      hideAll();
      // 直接把 PDF url 设置到 iframe（GitHub Pages 会返回正确的 content-type）
      pdfFrame.src = url;
      pdfFrame.style.display = 'block';
    }

    function showEPUB(url) {
      hideAll();
      epubReader.style.display = 'block';
      // epub.js 支持从 URL 加载 epub 文件（请保证文件可公开访问）
      book = ePub(url);
      rendition = book.renderTo(epubReader, { width: "100%", height: "72vh" });
      rendition.display();
    }
  </script>
</body>
</html>
