Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C6C433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Dec 2020 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CB2229C4
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Dec 2020 06:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLGGyV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Dec 2020 01:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGGyV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Dec 2020 01:54:21 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1AC0613D0
        for <fstests@vger.kernel.org>; Sun,  6 Dec 2020 22:53:40 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so8836968pfu.13
        for <fstests@vger.kernel.org>; Sun, 06 Dec 2020 22:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vFjncU9BZ8XJ9WQT/fIknFspVHs3K9jZoMJe+zoHaXo=;
        b=quHd368AfewhcRMKUUv5tNQ9dJEe0d7sz6vYpem25qh3xNNrCvzRcmAcoQrNFaS9B9
         V14wAsKfppCfTWZmSXVvd/0rvKsQ5NjXcVEVs03fpdoNQ95bZKkZ59lTTw3j0I8PY38i
         xQYyR3YWyAdLKZAymys/AY+10bxwCqz5JAJAhLRllGxd4c7IBam+siNOQxj9oPQnK2xi
         kLqE2WAXrqISdFSD8D6/uG+sDjc+J1Z+X57gVMczYWaHWAf+WbW0wY+1/K8wtnOAT9Gk
         K5Ln2bbi57PHrgo2X/ddZPASIYXCxtByaFeGhCbcW/5qCimsUFMJB7/j/x6n308tjORp
         4rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFjncU9BZ8XJ9WQT/fIknFspVHs3K9jZoMJe+zoHaXo=;
        b=PsgLgMYnCJBIJhwVmmGzYsK5DPLaYityd0pFiDXoSjKkz7juP/mSB2agzeb07o7YIT
         qQEQk3AY8CLiiruEDorFXxLOrsMQVwTFW5Mq718P49Lyove+WBqYd6a3gjqm8ZYGpvn+
         mx9VyL8oHoGK+W2QbH+vBQ/Gv43IWCk59l30vSUXXIUDgGF/0G482SorIAdvVw3Vhu9t
         uft+CFZ4ob1WwU4WLm8FlJRnPIVPiV+9n81w4wvwox2TNDNcO3eGGd33UQEMLyPMXyWa
         PFmh9heIVldYqLx1+09qPRnLA8iRPA0zAaBPjMQXhqm6/zIXjdvWbBzxqJkCq9DYN9An
         iK9Q==
X-Gm-Message-State: AOAM531RKjv0UWBti7Lem7yGdHG8Uq+0Y4AmPrATqeIT76tCmVG89ma+
        gm4NS4NwRXuRx5cfJwO6aH8=
X-Google-Smtp-Source: ABdhPJwiL+Ei35cJrIQkgG5Au3QQ1rSMyYjiPcy+DBuArQPqlSqtVDbEpIZUjkwx0qnTEdyRsmkadQ==
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id p9-20020a1709026b89b02900dafc41baecmr2187954plk.39.1607324020438;
        Sun, 06 Dec 2020 22:53:40 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x5sm9305768pjr.38.2020.12.06.22.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 22:53:39 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:53:32 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH] generic/506: require prjquota
Message-ID: <20201207065332.tfgdlroxgiiuxim6@xzhoux.usersys.redhat.com>
References: <20201202101521.15405-1-jencce.kernel@gmail.com>
 <20201206132116.GT3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206132116.GT3853@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 06, 2020 at 09:21:16PM +0800, Eryu Guan wrote:
> On Wed, Dec 02, 2020 at 06:15:21PM +0800, Murphy Zhou wrote:
> > To avoid false failure on overlayfs.
> > 
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  tests/generic/506 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/generic/506 b/tests/generic/506
> > index d5b28cad..edcda6db 100755
> > --- a/tests/generic/506
> > +++ b/tests/generic/506
> > @@ -42,6 +42,7 @@ rm -f $seqres.full
> >  # real QA test starts here
> >  _supported_fs generic
> >  
> > +_require_prjquota
> >  _require_scratch
> >  _require_scratch_shutdown
> 
> generic/506 already has _require_prjquota below, and it requires the
> device to be mounted first.
> 
> _qmount_option "prjquota"                                                                                                                                                                                                                      
> _qmount
> _require_prjquota $SCRATCH_DEV
> 
> So would you please give more details on the failure you want to fix?

qmount failed on overlayfs.

    -Silence is golden
    +mount: /loopsch/ovl-mnt: wrong fs type, bad option, bad superblock on /loopsch, missing codepage or helper program, or other error.
    +qmount failed> 

Since it's required to be mounted before checking, I guess it's better
to exclue this one for overlayfs.

Thanks for reviewing!

> Thanks,
> Eryu
> 
> >  
> > -- 
> > 2.20.1

-- 
Murphy
