Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA273C636D4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Feb 2023 05:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBOFXP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBOFXO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Feb 2023 00:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942DE3432E
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 21:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676438551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eqa5/9j7jpVrzk6Ulj7/6TbsPlc8NTiXphc53gYhxUI=;
        b=BtUwYVdJiDTaFme0floejBDHpzhBmoC0XieQ9UOdLFcoafKCCPyHxkdIE31tGEm6FwVarX
        uxswdHB/sjE5e0M7vamn6B/gZHyrlgblz13JZI5xlynVkenqCD1piillqEIGUTCEiCoh6M
        x7iz/nVnRzyGTJducPIlixZkXBDDcFY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-aU7J6l3ZOcyr8z4k0HKkHQ-1; Wed, 15 Feb 2023 00:22:30 -0500
X-MC-Unique: aU7J6l3ZOcyr8z4k0HKkHQ-1
Received: by mail-pf1-f200.google.com with SMTP id x2-20020a056a000bc200b005a8ea29c7a6so1349533pfu.15
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 21:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqa5/9j7jpVrzk6Ulj7/6TbsPlc8NTiXphc53gYhxUI=;
        b=8RtUyd81VjX4fP8fIOhhRJ4Uven2RI7jVFkGzHSJxzSL0ocyJxzPpiFoZl5zrJIEyK
         o7racZ3MRskEAfTn+s9BfJcXupS8L3XAS2itj/KA2LlK8nxMkK5Zb1paiflg2LcNR21O
         mRkMtAP4oANlf+g2mde8OXzFlWuTEBeZ3Gjt/7a+53KvlGeU0Jub082U9kBMYkMAp04p
         KQOhkRRlfEDcNVlR35F9Z0e2U+V2k0WudRk/OR+N8/2zIsjFhOddn/Fo+RkQeSdepdoV
         vVneitgrdlzsqn2QKjpuSwlkv+85Y3nWfTufcXJC2QbEisMF8E9GB9zTclwBQMf95MiG
         VqKQ==
X-Gm-Message-State: AO0yUKWaXqQHDPvI2iw9OvqNM0je0INL6YYw89YEj13G4oddw5FcTEPf
        Ud3K9LtDqXRMCTbbM6Ut3J5jT7WaoPtLy2ZuvHTqBSligubc0SG4V/6xmhr3VBYx8S032xlHx3e
        GWwS8HgykISLhJ1PivJHhyIuX/I4F
X-Received: by 2002:a17:902:c403:b0:19a:a9d8:e499 with SMTP id k3-20020a170902c40300b0019aa9d8e499mr1601112plk.44.1676438548664;
        Tue, 14 Feb 2023 21:22:28 -0800 (PST)
X-Google-Smtp-Source: AK7set9+yrnxdxtSzHKTeEpRLKC/tHRO0ueQQWp7g6+78HTp5FO9S1TylJQRqaeUiVYxMdwYq38xKw==
X-Received: by 2002:a17:902:c403:b0:19a:a9d8:e499 with SMTP id k3-20020a170902c40300b0019aa9d8e499mr1601089plk.44.1676438548233;
        Tue, 14 Feb 2023 21:22:28 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019a95baaaa6sm6001687plj.222.2023.02.14.21.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:22:27 -0800 (PST)
Date:   Wed, 15 Feb 2023 13:22:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
Message-ID: <20230215052224.oo62bcy4fkobngn6@zlang-mailbox>
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
 <20230214061748.z4to5y6dr4byw3y7@zlang-mailbox>
 <a197f440-1c3d-5898-800c-6712484ea073@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a197f440-1c3d-5898-800c-6712484ea073@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 12:34:14AM +0800, Anand Jain wrote:
> On 2/14/23 14:17, Zorro Lang wrote:
> > On Mon, Feb 13, 2023 at 05:45:09PM +0800, Anand Jain wrote:
> > > Add the _wants_kernel_commit tag for the benifit of testing on the older
> > > kernels.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > 
> > Besides this patch, you just sent another patchset:
> >    [PATCH 0/3] fstests: btrfs- add _fixed_by for new tests in the auto group
> > which try to add _fixed_by for some btrfs cases.
> > 
> 
>  Recently, these were added to the auto group.
> 
> > I think we don't need to "fix" these things one by one, by lots of small patch
> > pieces.
> 
>  ok.
> 
> > If there's not special reason (e.g. someone case need more fix besides
> > adding _fixed_by), how about combine them into one patch which "clarify the
> > _fixed_by or _wants commits for btrfs cases (or only for someone group)"
> > 
> 
>  Hmm.
>  btrfs/249 needs _wants_kernel_commit; btrfs/198, btrfs/185, and
>  btrfs/219 need _fixed_by_kernel_commit. Merge the latter and
>  send as one patch?

Either one or two patch are good to me, just don't need to one patch only add
one _fixed_by/_wants :)

Thanks,
Zorro

> 
> Thanks, Anand
> 
> 
> > Thanks,
> > Zorro
> > 
> > >   tests/btrfs/249 | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/btrfs/249 b/tests/btrfs/249
> > > index 7cc4996e387b..1b79e52dbe05 100755
> > > --- a/tests/btrfs/249
> > > +++ b/tests/btrfs/249
> > > @@ -13,7 +13,7 @@
> > >   #  Dump 'btrfs filesystem usage', check it didn't fail
> > >   #
> > >   # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
> > > -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> > > +#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
> > >   #   btrfs-progs: read fsid from the sysfs in device_is_seed
> > >   . ./common/preamble
> > > @@ -29,6 +29,8 @@ _supported_fs btrfs
> > >   _require_scratch_dev_pool 3
> > >   _require_command "$WIPEFS_PROG" wipefs
> > >   _require_btrfs_forget_or_module_loadable
> > > +_wants_kernel_commit a26d60dedf9a \
> > > +	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
> > >   _scratch_dev_pool_get 2
> > >   # use the scratch devices as seed devices
> > > -- 
> > > 2.31.1
> > > 
> > 
> 

