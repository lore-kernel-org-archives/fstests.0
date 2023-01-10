Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14DC46467
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 14:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAJONU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAJONQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 09:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD064F9
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673359950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oLtxlw5NQr6j574pRIpdKLcP45xIyvdULrznqpcz3s=;
        b=aMN0pGxRcKdKH4l65o3qgkvTDqbt5M/MhBo42l2BZ37dDYMMioY1fCECh7A8sMdFp2CRKW
        NGA0WwnBz83NurNeSV2oJmxMP/IRt+LZZMyuV7pEfeskFr2USVy1oseyCX3+zfm7PKj2YV
        pOkhicXVvochimhtCDyKTTFQjuGUWJI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-neQ0_LYdPFKqgBIAfuqO6g-1; Tue, 10 Jan 2023 09:12:29 -0500
X-MC-Unique: neQ0_LYdPFKqgBIAfuqO6g-1
Received: by mail-pl1-f197.google.com with SMTP id p14-20020a170902e74e00b00192f6d0600eso8480728plf.3
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 06:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oLtxlw5NQr6j574pRIpdKLcP45xIyvdULrznqpcz3s=;
        b=pnWqd6iBY7IuV2Oz9y9eWIqtLQHmez+FtFuEtzyOPceptFKIsrr6+51XxCuw/32UZA
         yNbhcSQM2IXut8/uubot1dbT4qYKmVFtekqgIn+gM2BtVG7YU6lD4gt7tyuXvROW+pbQ
         m1mdgc3NlGceEwnaSDSjJQAfjR+9LP/RtuRM3uF3ggSnhITEkWiXVY+WJEAXdSYFh3Cl
         aC9rpE3cIwgyGWEtSV1HN8HbcOm/KPmAKwLXEjMx0rqxYlFE0aVr01vXQGXNrkoSNPjT
         DOoOUgbFVEr5MZSH+pfgr+vlr9MZMZoFUNvnmPjU6U+s/sEtck7V4R3I7TDhqgyiooL9
         4dDA==
X-Gm-Message-State: AFqh2kr3yYcQstW9YdAGz4sWirv2ZDuEc4ZwDPZUSfYJEw/2Ge/J1umr
        GbURHbPd8DV9cGDEP7czTSgahQpAYR1vNcaPbmvQA78N3nqAGL3PPxp7SlS3J0XSQI3OG1zElO4
        0a5ARm5wohK7RM73O+g==
X-Received: by 2002:a05:6a00:1255:b0:576:b8e1:862b with SMTP id u21-20020a056a00125500b00576b8e1862bmr83028522pfi.14.1673359948303;
        Tue, 10 Jan 2023 06:12:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBcm+WnvzSTeN5NdXcAQfX21dpIyjlZSs+d6IgL64UAFe0QfUS/1UNQJyVBXO/Tu3A6gyKzA==
X-Received: by 2002:a05:6a00:1255:b0:576:b8e1:862b with SMTP id u21-20020a056a00125500b00576b8e1862bmr83028505pfi.14.1673359948014;
        Tue, 10 Jan 2023 06:12:28 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm8102982pfv.153.2023.01.10.06.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:12:27 -0800 (PST)
Date:   Tue, 10 Jan 2023 22:12:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/012: check if ext4 is available
Message-ID: <20230110141223.adgbm5oehxwh5tnw@zlang-mailbox>
References: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
 <20230110192321.34D5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110192321.34D5.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 10, 2023 at 07:23:22PM +0800, Wang Yugui wrote:
> Hi,
> 
> > btrfs/012 is requiring ext4 support to test the conversion, but the test
> > case is only checking if mkfs.ext4 is available, not if the filesystem
> > driver is actually available on the test host.
> > 
> > Check if the driver is available as well, before trying to run the test.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  tests/btrfs/012 | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > index 60461a342545..86fbbb7ac189 100755
> > --- a/tests/btrfs/012
> > +++ b/tests/btrfs/012
> > @@ -32,6 +32,8 @@ _require_command "$E2FSCK_PROG" e2fsck
> >  _require_non_zoned_device "${SCRATCH_DEV}"
> >  _require_loop
> >  
> > +grep -q ext4 /proc/filesystems || _notrun "no ext4 support"
> 
> when ext4 is module, and is not used, 'ext4' will not be in /proc/filesystems.

Really? Actually I'm not sure about that. There's an existing helper in
common/rc named _require_extra_fs(). Which we usually used to check if
a secondary filesystem is supported by the current kernel. Likes:

$ grep -rsn _require_extra_fs tests/
tests/generic/631:42:_require_extra_fs overlay
tests/generic/699:26:_require_extra_fs overlay
tests/overlay/025:36:_require_extra_fs tmpfs
tests/overlay/106:22:_require_extra_fs tmpfs
tests/overlay/107:22:_require_extra_fs tmpfs
tests/overlay/108:22:_require_extra_fs tmpfs
tests/overlay/109:22:_require_extra_fs tmpfs
tests/xfs/049:43:_require_extra_fs ext2

Thanks,
Zorro

> 
> so we need a right way to check ext4 support.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/10
> 

