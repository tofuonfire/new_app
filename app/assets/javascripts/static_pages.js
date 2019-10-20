// トップページ：未ログイン
  // 新着の投稿
  $(function() {
    $('.post-cards.latest').infiniteScroll({
      path : '.post-cards-footer.latest nav.pagination a[rel=next]',
      append : '.post-cards.latest .post-card',
      history: false,
      prefill: true,
      button: '.post-cards-footer.latest .loadmore-btn',
      scrollThreshold: false,
      hideNav: '.post-cards-footer.latest .pagination'
    })
  })
  $(function () {
    if($(".post-cards-footer.latest nav.pagination")[0]) {
    } else {
        $(".post-cards-footer.latest .loadmore-btn").hide();
    }
  });

  // 人気の投稿
  $(function() {
    $('.post-cards.popular').infiniteScroll({
      path : '.post-cards-footer.popular nav.pagination a[rel=next]',
      append : '.post-cards.popular .post-card',
      history: false,
      prefill: true,
      button: '.post-cards-footer.popular .loadmore-btn',
      scrollThreshold: false,
      hideNav: '.post-cards-footer.popular .pagination'
    })
  })
  $(function () {
    if($(".post-cards-footer.popular nav.pagination")[0]) {
    } else {
        $(".post-cards-footer.popular .loadmore-btn").hide();
    }
  });


// トップページ：ログイン済み
  // フィード
  $(function() {
    $('.following-posts-container').infiniteScroll({
      append : '.following-posts-container .post-frame',
      history: false,
      button: '.following-posts-footer .loadmore-btn',
      scrollThreshold: false,
      path : '.following-posts-footer nav.pagination a[rel=next]',
      hideNav: '.pagination'
    })
  })
  $(function () {
    if($(".following-posts-footer nav.pagination")[0]) {
    } else {
        $(".following-posts-footer .loadmore-btn").hide();
    }
  });

  // 新着の投稿
  $(function() {
    $('.home-post-cards.latest').infiniteScroll({
      append : '.home-post-cards.latest .post-card',
      history: false,
      button: '.home-posts-footer.latest .loadmore-btn',
      scrollThreshold: false,
      path : '.home-posts-footer.latest nav.pagination a[rel=next]',
      hideNav: '.home-posts-footer.latest .pagination'
    })
  })
  $(function () {
    if($(".home-posts-footer.latest nav.pagination")[0]) {
    } else {
        $(".home-posts-footer.latest .loadmore-btn").hide();
    }
  });

  // 人気の投稿
  $(function() {
    $('.home-post-cards.popular').infiniteScroll({
      append : '.home-post-cards.popular .post-card',
      history: false,
      button: '.home-posts-footer.popular .loadmore-btn',
      scrollThreshold: false,
      path : '.home-posts-footer.popular nav.pagination a[rel=next]',
      hideNav: '.home-posts-footer.popular .pagination'
    })
  })
  $(function () {
    if($(".home-posts-footer.popular nav.pagination")[0]) {
    } else {
        $(".home-posts-footer.popular .loadmore-btn").hide();
    }
  });