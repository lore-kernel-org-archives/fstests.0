Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46541C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 19:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjATTJN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjATTJM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 14:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96215CBA
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674241703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4CrSXL/ekm6A2qpPAPCzvXlL83Vd5odWOF6aeATbmA=;
        b=ICX/3+tIUn8KFzQi7iUYt36mIORq59tzrvH1aXwLzYCEOEkn9wSm9fd6opWf6dp9aCzL8M
        NzCSSHt4nS0waj+E4Pfm0MzvqAjjMv2ATq5IIwHpd3EryZdojoxRwtRrj9XTzdg4Bw+TN1
        73nWLsW/QTOzW51rtP+5whToOn30CTI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-504-X6Ca0DZCOpyrchXTuqHiDg-1; Fri, 20 Jan 2023 14:08:20 -0500
X-MC-Unique: X6Ca0DZCOpyrchXTuqHiDg-1
Received: by mail-pj1-f71.google.com with SMTP id t12-20020a17090a3e4c00b00225cb4e761cso2863532pjm.3
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 11:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4CrSXL/ekm6A2qpPAPCzvXlL83Vd5odWOF6aeATbmA=;
        b=OWgz2q+kQeW2vrxTSUl9QTiJ0XOIRyYdV/0hZKA+xKj4HzmOk4gaiw+lC8xboe0jQ0
         efkm7OZ/eJtwh90cAGStCCceXQdGYDt2SethVh4lwjEVqiyT17bWWaox8tQ5YdCKrXb1
         O8jh0ClN3YIClF3dLQQrUg6hPjEnhQCUY6NHfq6EfUgJ5YUpzrohcLkGP+dGfuws1Ltu
         JQXVPQd6KSAdOPAU6fvEP1623qYTb3kQkK7qLN/gfXvlWkfj7sMnoiZoSrEziRSa905r
         eG8RI5JkgVc4Qw5JnAWWjaqQtCfuj8UXIi3tOQKjBE8zbBM3W9rm7li8ye652zPzDqJK
         eBmw==
X-Gm-Message-State: AFqh2kr1UPA9BGb6pC8y6CmH68peiU9/e/LbVwJhyA9t6eBboEj9hJCn
        eyDJTYCMq7QGHbUMKmnrT6XmxKwISKzxKFKfE6VIucG5/7yQaZ3SULlv5O7AF6KZLiG+lAi4x88
        KWOVwnJhjpYRZeQJUog==
X-Received: by 2002:a62:1ac9:0:b0:57a:7b74:4ec5 with SMTP id a192-20020a621ac9000000b0057a7b744ec5mr16836824pfa.13.1674241699832;
        Fri, 20 Jan 2023 11:08:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsJtDr4XWM4fGUnzMpQYJLqhjq5jcyNKKIzsgWjIungHKJkuZWg07J9ThXMGMGYc0WtMcYuw==
X-Received: by 2002:a62:1ac9:0:b0:57a:7b74:4ec5 with SMTP id a192-20020a621ac9000000b0057a7b744ec5mr16836801pfa.13.1674241699496;
        Fri, 20 Jan 2023 11:08:19 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x5-20020a628605000000b0058bca264253sm11964887pfd.126.2023.01.20.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:08:19 -0800 (PST)
Date:   Sat, 21 Jan 2023 03:08:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck
Message-ID: <20230120190815.fajw7d2cgwim7cju@zlang-mailbox>
References: <20230119104618.28701-1-jack@suse.cz>
 <20230119105410.9236-1-jack@suse.cz>
 <20230120154123.7f59e1cc@echidna.fritz.box>
 <20230120154510.xgqweuagzmqup4ql@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120154510.xgqweuagzmqup4ql@quack3>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 20, 2023 at 04:45:10PM +0100, Jan Kara wrote:
> Hello!
> 
> On Fri 20-01-23 15:41:23, David Disseldorp wrote:
> > On Thu, 19 Jan 2023 11:54:02 +0100, Jan Kara wrote:
> > > udf_test program used for verifying filesystem is not able to determine
> > > filesystem blocksize. Provide it in the options together with disabling
> > > ecclength as it is not used on harddrives.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  common/rc | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 8060c03b7d18..de94e5a4cde4 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
> > >      fi
> > >  
> > >      local device=$1
> > > -    local opt_arg=""
> > > +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
> > 
> > It looks as though mkudffs also accepts --blocksize= for this, so it
> > should also be handled here, IIUC.

And _scratch_mkfs_sized need blocksize too. If udf support blocksize parameter,
you might like to take a look at that helper too, due to it always use 4096 for udf
blocksize.

Similar helpers are _scratch_mkfs_geom (maybe not suit for udf) and
_scratch_mkfs_blocksized.

Thanks,
Zorro

> 
> Thanks for review! I've fixed this.
> 
> 									Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

