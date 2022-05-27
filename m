Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C69C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 27 May 2022 04:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiE0EVl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 May 2022 00:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiE0EVk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 May 2022 00:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 454A5506FC
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653625298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SP2v7Ww8N51rd5j4I5PCAetPEZTZ5asgec2ImW27mJo=;
        b=BN+6RlZkHs3AiWz4fRHZmjBnDkM5cwne1/rCCuYvg/dJuOcHelPOeyEaiK8MBpt/rYkj9T
        3VrfbWaQrAKlpy0x3NRR74NhYBNR9oODOpyS7BCOtCP3AqGRxYso/87rlE6b6KTFJbRkZh
        KtREMir3M3A2YQChW6nzFSDIfISCbuk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-IDG7NfoRPxmRqiW-0Jdalw-1; Fri, 27 May 2022 00:21:35 -0400
X-MC-Unique: IDG7NfoRPxmRqiW-0Jdalw-1
Received: by mail-oi1-f199.google.com with SMTP id t206-20020aca5fd7000000b0032b53f108d3so1415663oib.5
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 21:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SP2v7Ww8N51rd5j4I5PCAetPEZTZ5asgec2ImW27mJo=;
        b=H2hwn8N38YFPrzqKZuMsf6OKAj3MFxjiz7rZg6XrAUFqtMWOddk2I0yoF5Pg6Ie5NC
         oNNte4NGz9KOSQVKLiMabIALfx9aIxdzwFCmJZwHy2TFNXZT8S+UAD3h3pjU5egjVZFd
         yiX42/UK4ne8EL+9JjMoTyV/HBEHwmGs6Ll7QSz1kYTYkQfajXqq9mKqYaQWfuLJNgNX
         VPwQvzv/IcsOgNgonLjbC9VjvwqKLuvfP0lbPjaweIOUX1IvxseUYHSgu8cFLVPltY3I
         c0T6Hk7iQPAOz52GlmzXwuyo7xQSiMejTv17W9t/ZE35z0Cs50EUPsst+QVE5Zlf9KU0
         IEUQ==
X-Gm-Message-State: AOAM532jhviSE4+6W5EK2972CLAeEx2JdIu+hz/PAh7sLnHMrVpe5aNX
        qe6JHupG0vWpzvqxlL7Ot6oaQoKQWtx33TbveVZfEGpC8LZshzqe9ft/00wnRRtcLZ0oCauZeoc
        7gfSExK3+pMI/0bxE0w==
X-Received: by 2002:a05:6870:580b:b0:f1:8489:343e with SMTP id r11-20020a056870580b00b000f18489343emr3322968oap.298.1653625294602;
        Thu, 26 May 2022 21:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBcm8p12BCHEDbJrIzqOtVx6fh/Is+iDcpJL4JBD5dfmhncL3CgqEbwevbhkroE8zFpNQG1w==
X-Received: by 2002:a05:6870:580b:b0:f1:8489:343e with SMTP id r11-20020a056870580b00b000f18489343emr3322962oap.298.1653625294388;
        Thu, 26 May 2022 21:21:34 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bi7-20020a056808188700b0032b7788af61sm1526347oib.41.2022.05.26.21.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 21:21:33 -0700 (PDT)
Date:   Fri, 27 May 2022 12:21:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter out extra mount error
Message-ID: <20220527042129.n3lmqzxzeghuulxp@zlang-mailbox>
References: <20220526095704.3772355-1-zlang@kernel.org>
 <20220526234506.GC3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526234506.GC3923443@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 09:45:06AM +1000, Dave Chinner wrote:
> On Thu, May 26, 2022 at 05:57:04PM +0800, Zorro Lang wrote:
> > The lastest mount command (from util-linux) merged below commit:
> >   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> > which brought in a new error output when mount fails.
> > 
> > That cause some cases (e.g. xfs/005) fail as:
> >   mount: Structure needs cleaning
> >          dmesg(1) may have more information after failed mount system call
> > 
> > More failed cases like generic/050, ext4/002, xfs/154, etc ...
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Due to _try_scratch_mount is call in many places, so I'm not sure if it's good
> > to filter this message in _try_scratch_mount. Maybe better to filter it in each
> > failed cases? Or write another function (e.g. _try_scratch_mount_fail) ?
> > Welcome review points.
> > 
> > Thanks,
> > Zorro
> > 
> >  common/rc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 70a15f9c..67342760 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -335,7 +335,8 @@ _try_scratch_mount()
> >  		_overlay_scratch_mount $*
> >  		return $?
> >  	fi
> > -	_mount -t $FSTYP `_scratch_mount_options $*`
> > +	_mount -t $FSTYP `_scratch_mount_options $*`  2> \
> > +		>(grep -v "dmesg(1) may have more information after failed mount" >&2)
> 
> _filter_error_mount()?

OK, how about this change [1] ?

Do you think doing this "filter out" in _try_scratch_mount is better, or in
each case which expects mount failures in .out file (e.g. xfs/005) ? Or a new
_try_scratch_mount_fail() ?

Thanks,
Zorro

[1]
diff --git a/common/filter b/common/filter
index a6a42b7a..54fb8d68 100644
--- a/common/filter
+++ b/common/filter
@@ -655,5 +655,10 @@ _filter_blkzone_report()
        sed -e 's/len/cap/2'
 }
 
+_filter_mount_error()
+{
+       grep -v "dmesg(1) may have more information after failed mount"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/common/rc b/common/rc
index 2f31ca46..c16bd405 100644
--- a/common/rc
+++ b/common/rc
@@ -288,7 +288,8 @@ _try_scratch_mount()
                _overlay_scratch_mount $*
                return $?
        fi
-       _mount -t $FSTYP `_scratch_mount_options $*`
+       _mount -t $FSTYP `_scratch_mount_options $*` 2> \
+               >(_filter_mount_error >&2)
        mount_ret=$?
        [ $mount_ret -ne 0 ] && return $mount_ret
        _idmapped_mount $SCRATCH_DEV $SCRATCH_MNT

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

