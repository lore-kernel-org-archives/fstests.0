Return-Path: <SRS0=+iS3=2F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED0C43603
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911DA206D3
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4dfDQZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLOQIC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:08:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLOQIC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Dec 2019 11:08:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so4252004pfh.7
        for <fstests@vger.kernel.org>; Sun, 15 Dec 2019 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7oXr4VRNJ4sChNeblK7rGgX4eaFz9JPmUv1N+yoGVa4=;
        b=t4dfDQZaGkni4kmeboqJeCW+YA3khHoTfCSimUPD/+P/iJoNZ+w+g5g7m/qcrlsqzG
         V+mMZz8bqZpwbD/vtQ+wmDbeJVxZlmEplSWzM2uP9jOKI6fOetxhPvnJRjFpgYRr4vno
         KGfGSQtXZw/NgUsDIbq23KMxXLwgVChCXaSafdpNJYt9TmeoQQXukbtop2D8+asPksAr
         HXdvG7VvbF362VjUSHxr7RU6U8MNjN3DHOi22Z/etaxKT7cmlj/7QHSUAOmCIGcUsNI/
         7Q06yhAedOGWgoHDGkUS6E1k7PtuqQhTALJtoO5rVxku0/WwwE2EtGAaAkhDIuC1FMEv
         XD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7oXr4VRNJ4sChNeblK7rGgX4eaFz9JPmUv1N+yoGVa4=;
        b=KOuie+0UbYfnlDpq2eZwe2qPYdP56qz/FgWKmYMKn/oFDM9tnnVnDC8EKFGRsmGBwp
         OjPxbUM8qIgPWU9Wkbtr9JJIxLaCYH0ZBWWXGzGbC5mNKbCa5G7/wmc80wFK+KdqsxPf
         jeQhDrj+8ke3OJKA8meeXmzp+49nXw2rWXofXWRenyXmCPkDoU7s2kX4hd6+CZp3BPEG
         tsFG2EDQ4qvKM1qW0Fcp+cxvnBd6nL4j+yO0G1PGDJy7o7UDe1l2Rvs0hMlQwnRhcJ+c
         ljtcVpOqMNe0ZFZv/BOsTCmCQUM0ZcMkWIle7JkXwEVpD8GCP8Cup8Bzoplbqk91MNbO
         8aCA==
X-Gm-Message-State: APjAAAUsbn5W4ILPQpgvMHBazPmDWhDzXnoZdzAwAmWrSaE+UtZHBV8u
        Wm4DV7vBDqpKYlWeu6rNy6U=
X-Google-Smtp-Source: APXvYqyj9r6Fs1ZRck3jUO6rRdboxhwSOGS12bka+W4GztcC0qnf03rhW1c84iiL2BvLLZlwlhDe9A==
X-Received: by 2002:a63:de4a:: with SMTP id y10mr12831445pgi.367.1576426081447;
        Sun, 15 Dec 2019 08:08:01 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id c8sm18508224pfj.106.2019.12.15.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:08:00 -0800 (PST)
Date:   Mon, 16 Dec 2019 00:07:55 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: prepend 0 to treat offset as octal
Message-ID: <20191215160751.GA1776323@desktop>
References: <20191212031152.1906287-1-naohiro.aota@wdc.com>
 <20191212060437.GA99869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212060437.GA99869@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 11, 2019 at 10:04:37PM -0800, Darrick J. Wong wrote:
> On Thu, Dec 12, 2019 at 12:11:52PM +0900, Naohiro Aota wrote:
> > The offsets printed by "od" are octal numbers. So, we need to add "0" at
> > the head of the $offset to parse it as an octal number.
> > 
> > Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> <grumble> Did the original patch author run all the tests that use
> _filter_od to make sure there weren't any regressions.  This fixes
> xfs/139 for me, so...

My apologies, I did test tests that use _filter_od, but clearly not
include xfs/139..

Eryu

> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D
> 
> > ---
> >  common/filter | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index 6140e58368d7..88fcb6ef68ee 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -495,7 +495,7 @@ _filter_od()
> >  		fi
> >  
> >  		offset="${line%% *}"
> > -		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
> > +		printf '%o%s\n' $(("0$offset" / BLOCK_SIZE)) "${line#$offset}"
> >  	done
> >  }
> >  
> > -- 
> > 2.24.0
> > 
