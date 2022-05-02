Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E25C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  2 May 2022 12:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385030AbiEBMXg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 May 2022 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385021AbiEBMXf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 May 2022 08:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77AF17064
        for <fstests@vger.kernel.org>; Mon,  2 May 2022 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651494004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TGDNNtvvmPBYk9bbgLa7c3X0Q+E4dpJoXPbL4ofXFs=;
        b=QplDDmc8sLQOO4B4mXecPtdvffl4Alkltm+FDqO09ytIKgpO2r3uiJz5LvuWpz9XOH3+yF
        9GJVXaiNg4LD6wtQBopFOuOlhiRgayuhyfaXPhjQyUli6B98SR9kOaDYRa+Vd8iDonxNlH
        YRLhocIROyHr3muywHvm8ahAfkvAZ9Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-mcq4I2opP7CYFJ9q1gnH7Q-1; Mon, 02 May 2022 08:20:03 -0400
X-MC-Unique: mcq4I2opP7CYFJ9q1gnH7Q-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020a05620a430600b0069c0f5ad4e2so10011426qko.2
        for <fstests@vger.kernel.org>; Mon, 02 May 2022 05:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TGDNNtvvmPBYk9bbgLa7c3X0Q+E4dpJoXPbL4ofXFs=;
        b=YUqaJHCT8bVlyYA8I8N20VWBG6By421IUd6krfnttlIvo3aIxihYpsOrr6696U+VdD
         5jOE4QQOpNUaDbJtJGt+vZBRmAnzsS/lcFC4Z4P2yel+uGcQGyf2Foc6bwpqApL4IGmR
         Avbi+tRBgjiSPd0RwOjRL1oEm/l51jUpAJnHDTjDl32PgR5+y1Dqe7rcrAmL27t63XNq
         w22UIAoCciCNr0vTG8LLUaagqTKMneueR+R5FSL2Mhy0zNmFXmP9fVn03say9W6dxrxT
         YYWQXhp2Ko6PN/KFrgfLAAvvg9QKzFGrATWYpSBY7ngyXipLMFfe1yMLqHl/ZQagBnKz
         e3WA==
X-Gm-Message-State: AOAM533sILg/1x/dcDdA/tp1V5rX1hPWkriIMhd2uj7y3AQ7ja0kf8u7
        Z44sb7HRcS+0e7xHG+guHeBNUtoqecA+xJqs3gxEMvx+2Fve+ZnV513SsFtNU7gXpD2YnWWKf30
        b59m7EFu4bNSgwmn30A==
X-Received: by 2002:a05:6214:2266:b0:456:2c5a:b45f with SMTP id gs6-20020a056214226600b004562c5ab45fmr9286660qvb.24.1651494003127;
        Mon, 02 May 2022 05:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFqNqjh3v1glNJulhtCzg12Stp86C68pY3HLcevbS9IUwIJqpC96g9aEBp/rP9LriOe387XA==
X-Received: by 2002:a05:6214:2266:b0:456:2c5a:b45f with SMTP id gs6-20020a056214226600b004562c5ab45fmr9286644qvb.24.1651494002828;
        Mon, 02 May 2022 05:20:02 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m6-20020a37bc06000000b0069fc13ce207sm4219773qkf.56.2022.05.02.05.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:20:02 -0700 (PDT)
Date:   Mon, 2 May 2022 08:20:00 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <Ym/McFNCTzmsLBak@bfoster>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym2szx2S3ontYsBf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym2szx2S3ontYsBf@casper.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 30, 2022 at 10:40:31PM +0100, Matthew Wilcox wrote:
> On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > (I do not love this, have not even compiled it; it's late.  We may be
> > better off just storing next_folio inside the folio_iter).
> 
> Does anyone have a preference for fixing this between Option A:
> 

After seeing the trace in my previous mail and several thousand
successful iterations of the test hack, I had reworked it into this
(which survived weekend testing until it ran into some other XFS problem
that looks unrelated):

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 278cc81cc1e7..aa820e09978e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -269,6 +269,7 @@ struct folio_iter {
 	size_t offset;
 	size_t length;
 	/* private: for use by the iterator */
+	struct folio *_next;
 	size_t _seg_count;
 	int _i;
 };
@@ -279,6 +280,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
 	fi->folio = page_folio(bvec->bv_page);
+	fi->_next = folio_next(fi->folio);
 	fi->offset = bvec->bv_offset +
 			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
 	fi->_seg_count = bvec->bv_len;
@@ -290,13 +292,15 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 {
 	fi->_seg_count -= fi->length;
 	if (fi->_seg_count) {
-		fi->folio = folio_next(fi->folio);
+		fi->folio = fi->_next;
+		fi->_next = folio_next(fi->folio);
 		fi->offset = 0;
 		fi->length = min(folio_size(fi->folio), fi->_seg_count);
 	} else if (fi->_i + 1 < bio->bi_vcnt) {
 		bio_first_folio(fi, bio, fi->_i + 1);
 	} else {
 		fi->folio = NULL;
+		fi->_next = NULL;
 	}
 }

So FWIW, that is just to say that I find option A to be cleaner and more
readable.

Brian

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 49eff01fb829..55e2499beff6 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -269,6 +269,7 @@ struct folio_iter {
>         size_t offset;
>         size_t length;
>         /* private: for use by the iterator */
> +       struct folio *_next;
>         size_t _seg_count;
>         int _i;
>  };
> @@ -280,19 +281,23 @@ static inline void bio_first_folio(struct folio_iter *fi,
> struct bio *bio,
> 
>         fi->folio = page_folio(bvec->bv_page);
>         fi->offset = bvec->bv_offset +
> -                       PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> +                       PAGE_SIZE * folio_page_idx(fi->folio, bvec->bv_page);
>         fi->_seg_count = bvec->bv_len;
>         fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
>         fi->_i = i;
> +       if (fi->_seg_count > fi->length)
> +               fi->_next = folio_next(fi->folio);
>  }
> 
>  static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  {
>         fi->_seg_count -= fi->length;
>         if (fi->_seg_count) {
> -               fi->folio = folio_next(fi->folio);
> +               fi->folio = fi->_next;
>                 fi->offset = 0;
>                 fi->length = min(folio_size(fi->folio), fi->_seg_count);
> +               if (fi->_seg_count > fi->length)
> +                       fi->_next = folio_next(fi->folio);
>         } else if (fi->_i + 1 < bio->bi_vcnt) {
>                 bio_first_folio(fi, bio, fi->_i + 1);
>         } else {
> 
> 
> and Option B:
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 49eff01fb829..554f5fce060c 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -290,7 +290,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  {
>         fi->_seg_count -= fi->length;
>         if (fi->_seg_count) {
> -               fi->folio = folio_next(fi->folio);
> +               fi->folio = __folio_next(fi->folio,
> +                               (fi->offset + fi->length) / PAGE_SIZE);
>                 fi->offset = 0;
>                 fi->length = min(folio_size(fi->folio), fi->_seg_count);
>         } else if (fi->_i + 1 < bio->bi_vcnt) {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index de32c0383387..9c5547af8d0e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1642,6 +1642,12 @@ static inline long folio_nr_pages(struct folio *folio)
>         return compound_nr(&folio->page);
>  }
> 
> +static inline struct folio *__folio_next(struct folio *folio,
> +               unsigned long nr_pages)
> +{
> +       return (struct folio *)folio_page(folio, nr_pages);
> +}
> +
>  /**
>   * folio_next - Move to the next physical folio.
>   * @folio: The folio we're currently operating on.
> @@ -1658,7 +1664,7 @@ static inline long folio_nr_pages(struct folio *folio)
>   */
>  static inline struct folio *folio_next(struct folio *folio)
>  {
> -       return (struct folio *)folio_page(folio, folio_nr_pages(folio));
> +       return __folio_next(folio, folio_nr_pages(folio));
>  }
> 
>  /**
> 
> 
> Currently running Option A through its paces.
> 

