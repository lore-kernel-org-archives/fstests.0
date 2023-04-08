Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA81C77B61
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Apr 2023 04:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDHEPP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 8 Apr 2023 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDHEPN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 8 Apr 2023 00:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64515D338
        for <fstests@vger.kernel.org>; Fri,  7 Apr 2023 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680927265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33esjvo7KiLF4s9rYYKWGY7SG9VQmgH0EZFnL8CG8Qo=;
        b=RygCGrFUrgo3i8eTLO8Uy6BBybPObAfl6z6vLvCi6CR2EyaHE7eOGmTuiZ0qjzSCdWn7Gs
        NPwUfOKI1MuSF9hgdKHFHTzHWrXDx2nRe6Aq9LS3nXE9RkRsK0KNQT3FVszUBQ017m6Mb0
        INlgymoDlFJ/N0Ejh/1VLOtKZ+cZgf4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-H5sKScUoNCur-wcL8OctVA-1; Sat, 08 Apr 2023 00:14:23 -0400
X-MC-Unique: H5sKScUoNCur-wcL8OctVA-1
Received: by mail-pl1-f200.google.com with SMTP id o9-20020a170902d4c900b001a2bef29d53so9328306plg.7
        for <fstests@vger.kernel.org>; Fri, 07 Apr 2023 21:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680927262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33esjvo7KiLF4s9rYYKWGY7SG9VQmgH0EZFnL8CG8Qo=;
        b=b4lvZwNeO+mvR/pnWlAsuIPXes7XJzAI3Cy1IZ4N2ztb12fHcXsA2ll76uhySw/5Zp
         mEg4On//RdlL6YFLDxxDpcz4RYw7pChQc4Ym2qcK/GQ4lSBnDygrPxGupCb1pXmCqM/N
         SAieJEmA32fyh/LUUmaWWG/nzHF329guo1u6RzmcVDFR7SC89ZIcb5+Zh/5OjjLyTru1
         SzRem4RIOdgmMsKzaQ2OEqo8yZ9webhNi1PnEytACgf5BKqMy4kAm7XiKcMA0nLwV06m
         uDU91XkeobVLy4GhoHzcWsXIRQiL/kvYkSI9LVqAjNU1BtC7P+KsaFHxxQ5pbWilmSCt
         4VIw==
X-Gm-Message-State: AAQBX9dmCJ/V660IBJP7iOWytQLZ9p4+EXE6jg5kE3OO/BorIhj6nyxf
        l75MjVT1V8BfKO6dijLjr4l52mFfh6GEJI9OH5UWab11DGIy/wyRj5j/EcnacH1zOifZF0qj5Ck
        uliJ/g5S9zzGNaDqakij8Qg2ny0W8
X-Received: by 2002:a05:6a20:8ed4:b0:de:af2f:fddb with SMTP id m20-20020a056a208ed400b000deaf2ffddbmr3993532pzk.23.1680927261865;
        Fri, 07 Apr 2023 21:14:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bjR2zIYaLwdRvG8P4cdbgW1KZbqJ/t23DjsUQ8Cjk8BQJbd3jQIl9FCILrv9UIyF3abAzU4g==
X-Received: by 2002:a05:6a20:8ed4:b0:de:af2f:fddb with SMTP id m20-20020a056a208ed400b000deaf2ffddbmr3993517pzk.23.1680927261403;
        Fri, 07 Apr 2023 21:14:21 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n9-20020a62e509000000b00580e3917af7sm3754448pff.117.2023.04.07.21.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:14:20 -0700 (PDT)
Date:   Sat, 8 Apr 2023 12:14:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] fstests: add MAINTAINERS and get_maintainer.pl files
Message-ID: <20230408041417.7gw34mzwaigqgsz2@zlang-mailbox>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-2-zlang@kernel.org>
 <282cbb5c-489b-2665-6512-ae5781bd0b46@nvidia.com>
 <20230406204824.xd7526whlmc6ghr4@zlang-mailbox>
 <40e95eb5-66d5-7504-968f-a29a50ea3b10@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e95eb5-66d5-7504-968f-a29a50ea3b10@nvidia.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 06, 2023 at 01:52:55PM -0700, John Hubbard wrote:
> On 4/6/23 13:48, Zorro Lang wrote:
> ...
> >>> The MAINTAINERS and get_maintainer.pl are copied from linux project,
> >>> then made some changes for fstests specially.
> >>
> >> Hi Zorro,
> >>
> >> Instead of forking 23,000+ lines of MAINTAINERS and 2600+ lines of
> >> script into a strange tools/ location ("tools/" would then mean fstests,
> >> and "scripts/" would mean "everything else), this upgrade really should
> >> simply be done in place.
> >>
> >> I don't see much in the following patches that *truly* requires forking
> >> these files. And if you fix them up in place, then more people will be
> >> able to find the fstests maintainers easily, too.
> > 
> > Hi John,
> > 
> > Thanks for your reviewing.
> > 
> > What's the meaning of "fix them up in place"? Do you suggest to change
> > the location/path of the the MAINTAINERS file and get_maintainer script,
> > or rewrite them simply and totally (from zero)?
> > 
> 
> I meant, change MAINTAINERS and scripts/get_maintainer.pl directly, so
> as to get the new information about fstests and maintainers. That 
> requires some effort, because you have to keep the existing functionality
> working, but I do think it's worth the effort. 

I doubt Linux project would like to accept that :)

Although linux/MAINTAINERS records the LTP maintainer list, it doesn't help
more on ltp patch itself. So even linux/MAINTAINERS would like to have a
field about fstests, but it's not what this patchset for.

I hope to record fstests reviewers/supporters/contributors/... in fstests
project. And help to point out which mailing list can be CCed (to get more
review) when someone have one fs specified patch to fstests.

Thanks,
Zorro

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

