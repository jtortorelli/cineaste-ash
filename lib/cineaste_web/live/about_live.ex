defmodule CineasteWeb.AboutLive do
  use CineasteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, active_tab: :gist)}
  end

  def render(assigns) do
    ~H"""
    <div class="prose prose-headings:font-display">
      <h1>About</h1>
    </div>
    <div role="tablist" class="tabs tabs-border mb-2">
      <a
        role="tab"
        phx-click="change-tab"
        phx-value-tabname={:gist}
        class={"tab #{@active_tab == :gist && "tab-active"} font-display"}
      >
        Gist
      </a>
      <a
        role="tab"
        phx-click="change-tab"
        phx-value-tabname={:history}
        class={"tab #{@active_tab == :history && "tab-active"} font-display"}
      >
        History
      </a>
      <a
        role="tab"
        phx-click="change-tab"
        phx-value-tabname={:acknowledgements}
        class={"tab #{@active_tab == :acknowledgements && "tab-active"} font-display"}
      >
        Acknowledgements
      </a>
    </div>
    <div :if={@active_tab == :gist}>
      {gist_block(assigns)}
    </div>
    <div :if={@active_tab == :history}>
      {history_block(assigns)}
    </div>
    <div :if={@active_tab == :acknowledgements}>
      {acknowledgements_block(assigns)}
    </div>
    """
  end

  def acknowledgements_block(assigns) do
    ~H"""
    <div class="mb-2">
      <div class="prose prose-headings:font-display">
        <h4>Influences</h4>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Godzilla%20Temple%20title.gif"
          title="Barry's Temple of Godzilla"
          name="Barry Goldberg"
          url="godzillatemple.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Godzilla%20Monster%202.jpg"
          title="Godzilla and Other Monster Music"
          url="godzillamonstermusic.com"
          name="Lawrence Tuczynski"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Godzilla%20Stomp%20Jr.jpg"
          title="Gary's Godzilla Zone"
          url="gojistomp.org"
          name="Gary"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/godzillatower.png"
          title="Godzilla Tower"
          url="angelfire.com/movies/GodzillaTower"
          name="Iguanoman"
        />
        <.acknowledgement_card
          title="Kaiju Headquarters"
          url="kaijuhq.org"
          name="Jordan Twining"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Kaiju%20Headquarters%20title.jpg"
        />
        <.acknowledgement_card
          title="Kaijuphile"
          url="kaijuphile.com"
          name="Clint Lee Warner & Brandon Waggle"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/KaijuPhile%20(1).jpg"
        />
        <.acknowledgement_card
          title="Monster Zero News"
          url="monsterzero.us"
          name="Aaron Smith"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Monster%20Zero%20News%20Header.jpg"
        />
        <.acknowledgement_card
          title="SciFi Japan"
          url="scifijapan.com"
          name="Keith Aiken & Bob Johnson"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/New%20Logo%20from%20Scifijapan.jpeg"
        />
        <.acknowledgement_card
          title="Stomp Tokyo"
          url="stomptokyo.com"
          name="Chris Holland & Scott Hamilton"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Stomptokyo%20Masthead.jpg"
        />
        <.acknowledgement_card
          title="Toho Kingdom"
          url="tohokingdom.com"
          name="Anthony Romero & Co."
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Toho%20Kingdom%20Banner.png"
        />
        <.acknowledgement_card
          title="Tokyo Monsters"
          url="tokyomonsters.com"
          name="James Ballard"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/influences/Tokyo%20Monsters%20Banner.jpg"
        />
      </div>
    </div>
    <div class="mb-2">
      <div class="prose prose-headings:font-display">
        <h4>Resources</h4>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <.acknowledgement_card
          title="The Japanese Movie Database"
          url="jmdb.ne.jp"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/jmdb.png"
        />
        <.acknowledgement_card
          title="Japanese Wikipedia"
          url="ja.wikipedia.org"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/ja-wikipedia.png"
        />
        <.acknowledgement_card
          title="Kadokawa's Official Film Library"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/Kadokawa%20logo.png"
        />
        <.acknowledgement_card
          title="KaijuCast"
          url="kaijucast.com"
          name="Kyle Yount"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/Header%20Background.png"
        />
        <.acknowledgement_card
          title="Midnight Eye"
          url="midnighteye.com"
          name="Tom Mes, Jasper Sharp & Martin Mes"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/Midnight%20Eye%20logo.png"
        />
        <.acknowledgement_card
          title="Toho's Official Film Library"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/Movie%20Room%20Logo.jpg"
        />
        <.acknowledgement_card
          title="Vantage Point Interviews"
          url="vantagepointinterviews.com"
          name="Brett Homenick"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/resources/vantagepointinterviews.png"
        />
      </div>
    </div>
    <div class="mb-2">
      <div class="prose prose-headings:font-display">
        <h4>Books</h4>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <.acknowledgement_card
          title="A Critical History and Filmography of Toho's Godzilla Series"
          name="David Kalat"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Godzilla%20Series%20Book.jpg"
        />
        <.acknowledgement_card
          title="The Big Book of Japanese Giant Monster Movies"
          name="John LeMay"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Japanese%20Monster%20Book.jpg"
        />
        <.acknowledgement_card
          title="Godzilla FAQ"
          name="Brian Solomon"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Godzilla%20FAQ%20book.jpg"
        />
        <.acknowledgement_card
          title="Godzilla On My Mind"
          name="William Tsutsui"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Godzilla%20on%20My%20Mind%20book.jpg"
        />
        <.acknowledgement_card
          title="Godzilla: The Official Guide to the King of the Monsters"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Godzilla%20Ultimate%20Guide.jpg"
        />
        <.acknowledgement_card
          title="Ishiro Honda: A Life in Film, from Godzilla to Kurosawa"
          name="Steve Ryfle & Ed Godziszewski"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Ishiro%20Honda%20book.jpg"
        />
        <.acknowledgement_card
          title="Monsters Are Attacking Tokyo!"
          name="Stuart Galbraith IV"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Maat%20Monsters%20Attack%20Tokyo.jpg"
        />
        <.acknowledgement_card
          title="The Official Godzilla Compendium"
          name="J.D. Lees & Marc Cerasini"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Godzilla%20Compendium%20RH.jpg"
        />
        <.acknowledgement_card
          title="Something Like An Autobiography"
          name="Akira Kurosawa"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/books/Something%20Like%20An%20Autobiography.jpg"
        />
      </div>
    </div>
    <div class="mb-2">
      <div class="prose prose-headings:font-display">
        <h4>Labels</h4>
      </div>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/AD%20Vision%20logo.png"
          title="ADV Films"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Anchor%20Bay%20Entertainment%20logo.png"
          title="Anchor Bay"
        />
        <.acknowledgement_card
          url="arrowvideo.com"
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Arrow%20Video%203.svg.png"
          title="Arrow Video"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Classic%20Media.png"
          title="Classic Media"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Columbia%20TriStar%20Television.png"
          title="Columbia/TriStar"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Criterion%20Collection%20Logo.png"
          title="The Criterion Collection"
          url="criterion.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Discotek%20Logo.png"
          title="Discotek"
          url="discotekmedia.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Eleven%20Arts%20Logo.webp"
          title="Eleven Arts"
          url="elevenarts.net"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Funimation%20logo%20(1).png"
          title="Funimation"
          url="funimation.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Geneon%20logo.png"
          title="Geneon"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/GKIDS%20logo.png"
          title="GKIDS"
          url="gkids.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Kraken%20Releasing%20Logo.jpg"
          title="Kraken Releasing"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Magnet%20Logo%20Entertainment.png"
          title="Magnet"
          url="magnetreleasingfilms.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Media%20Blasters%20Logo.png"
          title="Media Blasters"
          url="media-blasters.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Mill%20Creek%20Entertainment%20R%2059.jpeg"
          title="Mill Creek Entertainment"
          url="millcreekent.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Miramax%20Films%20logo.png"
          title="Miramax"
          url="miramax.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Shout%20Factory%20logo.webp"
          title="Shout Factory"
          url="shoutfactory.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Sony%20Pictures%20Logo.png"
          title="Sony Pictures"
          url="sonypictures.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/SRS%20Cinema%20Logo.webp"
          title="SRS Cinema"
          url="srscinemastore.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Viz%20Red%20Logo.webp"
          title="Viz Pictures"
          url="viz.com"
        />
        <.acknowledgement_card
          image_url="https://tcpyguvhxiihxcocbhoh.supabase.co/storage/v1/object/public/godzilla-cineaste-public/content/about/acknowledgements/labels/Well%20Go%20USA%20Logo.png"
          title="Well Go USA Entertainment"
          url="wellgousa.com"
        />
      </div>
    </div>
    """
  end

  attr :image_url, :string
  attr :url, :string, default: nil
  attr :title, :string
  attr :name, :string, default: nil

  def acknowledgement_card(assigns) do
    ~H"""
    <div class="card md:w-48 max-h-32 min-h-32 card-xs bg-base-100 image-full shadow-sm">
      <figure>
        <img class="w-fit !h-auto" src={@image_url} />
      </figure>
      <div class="card-body">
        <h2 class="card-title font-display">{@title}</h2>
        <code :if={@url}>{@url}</code>
        <p :if={@name} class="font-content">
          {@name}
        </p>
      </div>
    </div>
    """
  end

  def gist_block(assigns) do
    ~H"""
    <div class="prose prose-p:font-content">
      <p>
        The Godzilla Cineaste is a fan-made website dedicated to Japanese science fiction and fantasy films. The nucleus of the site’s content is kaiju eiga, that is, the “monster film” genre, with which I’ve held a life-long fascination. The scope of the site grew as I continued developing it until it became what you see now. I haven’t been to all the conventions and haven’t spoken to all the stars (but I’d sure love to sometime). I’m just a guy who’s spent a long time collecting movies and learning how to code. As mentioned on the home page, this site is a labor of love, so updates will occur infrequently and without warning (I’m also a family guy, so, you know, priorities).
      </p>
    </div>
    """
  end

  def history_block(assigns) do
    ~H"""
    <div>
      <ul class="timeline timeline-snap-icon max-2xl:timeline-compact timeline-vertical">
        <li>
          <div class="timeline-middle">
            <%!-- <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="icon icon-tabler icons-tabler-outline icon-tabler-brush"
            >
            </svg> --%>
            <%!-- <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="icon icon-tabler icons-tabler-outline icon-tabler-bulb"
            >
            </svg> --%>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              class="h-5 w-5 icon icon-tabler icons-tabler-outline icon-tabler-bulb"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M3 12h1m8 -9v1m8 8h1m-15.4 -6.4l.7 .7m12.1 -.7l-.7 .7" /><path d="M9 16a5 5 0 1 1 6 0a3.5 3.5 0 0 0 -1 3a2 2 0 0 1 -4 0a3.5 3.5 0 0 0 -1 -3" /><path d="M9.7 17l4.6 0" />

              <%!-- <path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M3 21v-4a4 4 0 1 1 4 4h-4" /><path d="M21 3a16 16 0 0 0 -12.8 10.2" /><path d="M21 3a16 16 0 0 1 -10.2 12.8" /><path d="M10.6 9a9 9 0 0 1 4.4 4.4" /> --%>

              <%!-- <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                clip-rule="evenodd"
              /> --%>
            </svg>
          </div>
          <div class="timeline-end mb-10">
            <time class="font-mono italic">2004</time>
            <div class="prose prose-p:font-content">
              <p>
                The cineaste embarked on his first foray into web design by teaching himself HTML & CSS and carefully curating his hex color combinations for maximum cringe. Every page was hand coded with Microsoft Notepad. The site’s working title was “Godzilla Universes,” conceived primarily as a dumping ground for all the useless information about Godzilla he’d been carting around in his head. (Making the site easily navigable and visually appealing was a secondary concern.)
              </p>
            </div>
          </div>
          <hr />
        </li>
        <li>
          <hr />
          <div class="timeline-middle">
            <%!-- <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="icon icon-tabler icons-tabler-outline icon-tabler-rocket"
            >
            </svg> --%>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="h-5 w-5 icon icon-tabler icons-tabler-outline icon-tabler-rocket"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M4 13a8 8 0 0 1 7 7a6 6 0 0 0 3 -5a9 9 0 0 0 6 -8a3 3 0 0 0 -3 -3a9 9 0 0 0 -8 6a6 6 0 0 0 -5 3" /><path d="M7 14a6 6 0 0 0 -3 6a6 6 0 0 0 6 -3" /><path d="M15 9m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />

              <%!-- <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                clip-rule="evenodd"
              /> --%>
            </svg>
          </div>
          <div class="timeline-end md:mb-10">
            <time class="font-mono italic">2006</time>
            <div class="prose prose-p:font-content">
              <p>
                The cineaste launched the site to the world as “The Godzilla Database,” but soon relented and renamed it to “The Godzilla Cineaste” to match the domain his dad bought. The site was filled with incomplete pages and broken links and the cineaste wasn’t very proud of that at the time. Website updates were accomplished via FTP with FileZilla and CyberDuck. Updates were limited by the cineaste’s college schedule.
              </p>
            </div>
          </div>
          <hr />
        </li>
        <li>
          <hr />
          <div class="timeline-middle">
            <%!-- <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="icon icon-tabler icons-tabler-outline icon-tabler-barrier-block"
            >
            </svg> --%>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="h-5 w-5 icon icon-tabler icons-tabler-outline icon-tabler-barrier-block"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M4 7m0 1a1 1 0 0 1 1 -1h14a1 1 0 0 1 1 1v7a1 1 0 0 1 -1 1h-14a1 1 0 0 1 -1 -1z" /><path d="M7 16v4" /><path d="M7.5 16l9 -9" /><path d="M13.5 16l6.5 -6.5" /><path d="M4 13.5l6.5 -6.5" /><path d="M17 16v4" /><path d="M5 20h4" /><path d="M15 20h4" /><path d="M17 7v-2" /><path d="M7 7v-2" />

              <%!-- <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                clip-rule="evenodd"
              /> --%>
            </svg>
          </div>
          <div class="timeline-end mb-10">
            <time class="font-mono italic">2009</time>
            <div class="prose prose-p:font-content">
              <p>
                The cineaste took a formal web design course and decided his website really did suck and took the whole thing down until he could rewrite it from scratch. Unfortunately the cineaste was (and kinda still is) a perfectionist and refused to release anything until it was just right. The site was “under construction” for seven years while the cineaste puttered around, slowly collecting movies and learning how to code.
              </p>
            </div>
          </div>
          <hr />
        </li>
        <li>
          <hr />
          <div class="timeline-middle">
            <%!-- <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="icon icon-tabler icons-tabler-outline icon-tabler-sunset-2"
            >
            </svg> --%>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="h-5 w-5 icon icon-tabler icons-tabler-outline icon-tabler-sunset-2"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" /><path d="M3 13h1" /><path d="M20 13h1" /><path d="M5.6 6.6l.7 .7" /><path d="M18.4 6.6l-.7 .7" /><path d="M8 13a4 4 0 1 1 8 0" /><path d="M3 17h18" /><path d="M7 20h5" /><path d="M16 20h1" /><path d="M12 5v-1" />

              <%!-- <path
                fill-rule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                clip-rule="evenodd"
              /> --%>
            </svg>
          </div>
          <div class="timeline-end md:mb-10">
            <time class="font-mono italic">2016</time>
            <div class="prose prose-p:font-content">
              <p>
                The cineaste had a real life grown up job by this point and was newly married. The missus knew the cineaste had been fretting about the site for a while and told him to “just do it and have fun.” Later that same year the Godzilla Cineaste relaunched with a brand new look and a 100% reduction in broken janky pages. This version of the site is the one the cineaste continues to maintain and iterate on today.
              </p>
            </div>
          </div>
          <hr />
        </li>
      </ul>
    </div>
    """
  end

  def handle_event("change-tab", %{"tabname" => tabname}, socket) do
    {:noreply, assign(socket, active_tab: String.to_existing_atom(tabname))}
  end
end
