Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05BBEB64D9
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 13:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGDNxp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGDNxo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Jul 2023 09:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB50EE
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688478779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2arULlihPx+alvBnLxpjFitWjbTRZ08gyjzH/+hsu0=;
        b=Z7N1PlsHFE7GWgSPsb7zR4xUiLSG6Vn5zSeMJS16MAuNZIPn3Eyzj/iiw/jejO87OMGSFr
        iyM+niXu4vIyE4S4gjyv4qYbf6ddfwWFtcaKOXxxFTED1oBff/sy6ft1IjZ83KFP2cId1t
        lQVIA93cBMjYJ6LC+yI+hI6kcnW10Bg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-werI3gGjP9apPpLDUy-2Gg-1; Tue, 04 Jul 2023 09:52:55 -0400
X-MC-Unique: werI3gGjP9apPpLDUy-2Gg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-400fea3d458so59427491cf.1
        for <fstests@vger.kernel.org>; Tue, 04 Jul 2023 06:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478774; x=1691070774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2arULlihPx+alvBnLxpjFitWjbTRZ08gyjzH/+hsu0=;
        b=PqE+svyUyU9a2ykXhksVqZ38a4CHRzFy5sPMH0uNpErt5hiDZ55GosnWti7eFFS6QQ
         roYAlIeQUFv8sJgQCyByXuGh3j6d7dTLOa1LK4mRwtEAr6CUpqX84aQ0WA+snnBAcEMf
         VLngAzAaYZ1R+k6Gbr807xq7c8HV4bw2yAXTvwS8aVnUddSkM5EUiyJezXLuY6+/fpES
         G3HIisbAtCb9o8AkZJU4MP88KKWYMgHwC6BhmfB+lVSep3TazyscJ4qfK2R8LWWUYhci
         T8CLdP6cjn1onOGCv+1K7/qHdB9Ia/pzdp2wvD4EnuWgkQly4ZGz6yhVgZEQOIOhaoeo
         qvMw==
X-Gm-Message-State: AC+VfDxEZTztxQ7Q2Kot816ZGbH/kNS11SjGVIL/i824xdDUNdOnhJsI
        Rg5BNh/A89xBjqNg3fZdX3x5S8F+pdCFqqJm+aY13vgoGPKKkFZGuh98Q4pIglMCVlqJqwAbADf
        ZAMqHtVjG2cfDn4rR
X-Received: by 2002:ac8:5a49:0:b0:403:2e12:69af with SMTP id o9-20020ac85a49000000b004032e1269afmr14012092qta.55.1688478774692;
        Tue, 04 Jul 2023 06:52:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7E9kHUoh0dd2H+8k/11lO9fCn5h3hdyCONUX9JExbg79EJ2imUN0unochH45cH7dgJ7p1ggQ==
X-Received: by 2002:ac8:5a49:0:b0:403:2e12:69af with SMTP id o9-20020ac85a49000000b004032e1269afmr14012078qta.55.1688478774401;
        Tue, 04 Jul 2023 06:52:54 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f3-20020ac80683000000b003ef189ffa82sm1763192qth.90.2023.07.04.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:52:54 -0700 (PDT)
Date:   Tue, 4 Jul 2023 15:52:51 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 1/5] xfs/529: fix bogus failure when realtime is
 configured
Message-ID: <20230704135251.epcdagmqd3mseonp@aalbersh.remote.csb>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840381873.1317961.17241883212352752910.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168840381873.1317961.17241883212352752910.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-03 10:03:38, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If I have a realtime volume configured, this test will sometimes trip
> over this:
> 
> XFS: Assertion failed: nmaps == 1, file: fs/xfs/xfs_dquot.c, line: 360
> Call Trace:
>  xfs_dquot_disk_alloc+0x3dc/0x400 [xfs 97e1fa8953d397b1fb9732df4de7fa9070bda501]
>  xfs_qm_dqread+0xc9/0x190 [xfs 97e1fa8953d397b1fb9732df4de7fa9070bda501]
>  xfs_qm_dqget+0xa8/0x230 [xfs 97e1fa8953d397b1fb9732df4de7fa9070bda501]
>  xfs_qm_vop_dqalloc+0x160/0x600 [xfs 97e1fa8953d397b1fb9732df4de7fa9070bda501]
>  xfs_setattr_nonsize+0x318/0x520 [xfs 97e1fa8953d397b1fb9732df4de7fa9070bda501]
>  notify_change+0x30e/0x490
>  chown_common+0x13e/0x1f0
>  do_fchownat+0x8d/0xe0
>  __x64_sys_fchownat+0x1b/0x20
>  do_syscall_64+0x2b/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fa6985e2cae
> 
> The test injects the bmap_alloc_minlen_extent error, which refuses to
> allocate file space unless it's exactly minlen long.  However, a
> precondition of this injection point is that the free space on the data
> device must be sufficiently fragmented that there are small free
> extents.
> 
> However, if realtime and rtinherit are enabled, the punch-alternating
> call will operate on a realtime file, which only serves to write 0x55
> patterns into the realtime bitmap.  Hence the test preconditions are not
> satisfied, so the test is not serving its purpose.
> 
> Fix it by disabling rtinherit=1 on the rootdir so that we actually
> fragment the bnobt/cntbt as required.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/529 |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/tests/xfs/529 b/tests/xfs/529
> index 83d24da0ac..cd176877f5 100755
> --- a/tests/xfs/529
> +++ b/tests/xfs/529
> @@ -32,6 +32,10 @@ echo "Format and mount fs"
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
>  _scratch_mount -o uquota >> $seqres.full
>  
> +# bmap_alloc_minlen_extent only applies to the datadev space allocator, so
> +# we force the filesystem not to use the realtime volume.
> +_xfs_force_bdev data $SCRATCH_MNT
> +

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

