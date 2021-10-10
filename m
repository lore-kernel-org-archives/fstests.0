Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A11BC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AAF60F4B
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 08:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJJIdc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Oct 2021 04:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhJJIdb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Oct 2021 04:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633854692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWm6MZEgsIqvR/LGmdBzAuow2ZxRc8S3j2PHzbeom1E=;
        b=Qw39YqL6q5cETCBx4VmGYN0ke1YThXXJz6oXg8fxIFodH0e2Kr0Q5UZfJVv88OWcgaWCr3
        zPvkZ7aEF+L/ab7O2/tqGtCr5BfYLhx1mjzpg3rfWAV0OYR9eyOedDCx4mp4xlw8WhgAQR
        LPVHrIV6wufX0/6TEB2SmHYNMKlKNI0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-G0pbelEwNJGhbQWqhqf2bQ-1; Sun, 10 Oct 2021 04:31:31 -0400
X-MC-Unique: G0pbelEwNJGhbQWqhqf2bQ-1
Received: by mail-pf1-f198.google.com with SMTP id v13-20020a056a00148d00b0044ccf66dbd1so3234893pfu.4
        for <fstests@vger.kernel.org>; Sun, 10 Oct 2021 01:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wWm6MZEgsIqvR/LGmdBzAuow2ZxRc8S3j2PHzbeom1E=;
        b=Iq13m66Ymos3N3Gs+FBI10LrENh3UWUyFUp1/QqtCFAwnYmMRzjP8GNmOUx8VtKnbH
         Nr39lz5/+sHU3j6WuEF4Uh/L07rKVTL2lgAsGoWDuT7l23d8WEU0+lmFdghTR/hcuyFB
         +lc1dqoLi0VCpJMvLKmwYOIo6w3O5HTgv8EVR+wtlbn3SHcuxgteYclvv/jgzCzKTLsC
         vOWKG6vlRIgqbLNG95kxAQaSYf03NHdCExeOxBaNmkWm2WL3DTCdXYGNnvRhj9TaAgMp
         bu1YovSWPWt42Q5s8xk7jz6fbQugSBogLLiG5w6J98tVQdXJ1fP2kvd3CLPI8cPBsTvt
         7WCg==
X-Gm-Message-State: AOAM531dnDue9U+EFJ0T6JMW9P6yN19P3aV8XuSsXHBJB/A82qX4aLST
        dFRxEBGTuzlN+gwqeKBvb71mh1zC2idlnuDp51k4+HIi2F5/fZeGw1M7qnfmVBMHBkIZ65TimLe
        uwge1QsNGVcAjtlEbeA==
X-Received: by 2002:a17:90b:4c4c:: with SMTP id np12mr22668210pjb.205.1633854690239;
        Sun, 10 Oct 2021 01:31:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylVddTVKM9QEike7OQzKOWn6zbeUYL/x8CwGY3KrZpaUXePVUcXZ5G8dw+YawN/BTqCsNjSQ==
X-Received: by 2002:a17:90b:4c4c:: with SMTP id np12mr22668194pjb.205.1633854689960;
        Sun, 10 Oct 2021 01:31:29 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14sm4018034pfr.123.2021.10.10.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 01:31:29 -0700 (PDT)
Date:   Sun, 10 Oct 2021 16:31:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, fio@vger.kernel.org
Subject: Re: generic/095 failing in ext4 and xfs
Message-ID: <20211010083125.dne6pcjjboixdllo@fedora>
Mail-Followup-To: Luis Henriques <lhenriques@suse.de>,
        fstests@vger.kernel.org, fio@vger.kernel.org
References: <YVdBVdOjPLCayG1k@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVdBVdOjPLCayG1k@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 01, 2021 at 06:11:49PM +0100, Luis Henriques wrote:
> Hi!
> 
> I'm seeing generic/095 failing both with ext4 and xfs (but not on btrfs).
> Here's what I'm getting:
> 
> # cat results/generic/095.out.bad 
> QA output created by 095
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=51200, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=133120, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=92160, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=158720, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=513024, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=33792, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file2: Invalid argument: write offset=449536, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=45056, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=30720, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=222208, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: read offset=342016, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=177152, buflen=1024
> fio: pid=4090, got signal=11
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=43008, buflen=1024
> fio: io_u error on file /tmp/mnt/scratch/file1: Invalid argument: write offset=308224, buflen=1024
> fio: pid=4086, got signal=11

I *guess* it might be caused by a striped storage(fs) of you?

Thanks,
Zorro

> Silence is golden
> 
> This was for ext4 but the output for xfs is similar.  Since fio is getting
> killed I suspect this may be an issue with this tool.  Thus I'm sending
> this to both fio and fstests mailing-lists.
> 
> I'm using a 5.15-rc3 kernel and fio-3.28.  Is anyone else seeing something
> similar?
> 
> Cheers,
> --
> Luís
> 

