Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90293C11F64
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 10:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5976D61580
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhGAKrQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236040AbhGAKrO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Jul 2021 06:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625136284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rDbycBebGghL+Wa9Bic/nZB/TA70ja/pYklknCuUfH8=;
        b=BjuoPIaN6wUyDPabXQtRU5xJDqh0qLiRBbQg0csi2ncVjoo1WJJtjQ+qTnFa/w/I1a8RML
        tAWJJz0CyoQ+2SOAeBcllPf/35KGsMzjhaN2y1Jnl9k11/q6ScibDBGUx68q1hocVBKDNm
        NhJseHuAtmoKScQTqDhUlBzxrRwk7g8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-cZDyqi28PcCcAH5_rfDRkQ-1; Thu, 01 Jul 2021 06:44:43 -0400
X-MC-Unique: cZDyqi28PcCcAH5_rfDRkQ-1
Received: by mail-oo1-f72.google.com with SMTP id r4-20020a4ab5040000b02902446eb55473so3118276ooo.20
        for <fstests@vger.kernel.org>; Thu, 01 Jul 2021 03:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rDbycBebGghL+Wa9Bic/nZB/TA70ja/pYklknCuUfH8=;
        b=sOIKMZ5I17a3SYOAN6umDuF1aj+wcEyAx41ZIpgggDy9ATA4dKSx/nPp2S/KBo+VGF
         5AbZ1VgXm4FAJbyWdzfPJw+djyXrJbYBorcz8x8sezEJRLKYUTu1dB4F2/JVtIeU7bSo
         Oiwh6rm0jmdPN+qLkyft+suBcxJSIR2pAaCwbUyYII35O9doY0tyzeRCQq3A/wdhnJT4
         /2VTdiEPvutNUe2kQ9N9x1I3blp6iWyXc7XlykDGDCUJxcnDXnY1yyWATGYOn7N5jYdq
         vO6NdQA3ew6t8oR28NHn2GLCgs583fx4sPYiGezINP4/zboR0d+FylCqd9jvHSelck6L
         Topw==
X-Gm-Message-State: AOAM531laDcQRmHsSp89Ow/NNOJrWprM4LjrkGTIzE28ohB1pzUFBsk0
        kG+lH0UI99QbqKQZ4tAJAlauBtYjfkh1yESDtUAO43Yh0pkedVfGt6RUup/3eOxGtaubcSH38S/
        mxrZ8RNHKZoyWzUDBoPsCzcltbVZPVRBYlQ==
X-Received: by 2002:a4a:2242:: with SMTP id z2mr12482983ooe.90.1625136281807;
        Thu, 01 Jul 2021 03:44:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzupHUMbsiVcC+wkbryxZKzrHao3EFAfLzZacnJYekK1NCWKUfyIeoLfJfl2phnQ4BQS6/YsSV2c/XIWwVUfk8=
X-Received: by 2002:a4a:2242:: with SMTP id z2mr12482967ooe.90.1625136281623;
 Thu, 01 Jul 2021 03:44:41 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 1 Jul 2021 12:44:30 +0200
Message-ID: <CA+QYu4pPRr-KQB2b1YsZSYfAb11_hnL+UH8WTj3N5_x9yX8WnA@mail.gmail.com>
Subject: 1 lock held by xfs_repair/276634
To:     linux-fsdevel@vger.kernel.org
Cc:     fstests@vger.kernel.org, CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

We have hit this lock problem during xfstest [1] on aarch64. The whole
console.log is available on [2].

10847.013727] run fstests generic/023 at 2021-05-15 17:21:46
[10863.635560] XFS (sda4): Unmounting Filesystem
[10865.095328] BUG: sleeping function called from invalid context at (null):3550
[10865.102695] in_atomic(): 0, irqs_disabled(): 128, non_block: 0,
pid: 276634, name: xfs_repair
[10865.111223] 1 lock held by xfs_repair/276634:
[10865.115579]  #0: ffff000168f654d0
(&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_exit_release+0x40/0xe4
[10865.125091] irq event stamp: 150
[10865.128314] hardirqs last  enabled at (149): [<ffff8000101a2778>]
uaccess_ttbr0_enable+0xa8/0xc0
[10865.137096] hardirqs last disabled at (150): [<ffff8000101a2838>]
uaccess_ttbr0_disable+0xa8/0xb4
[10865.145964] softirqs last  enabled at (132): [<ffff800010016490>]
put_cpu_fpsimd_context+0x30/0x70
[10865.154921] softirqs last disabled at (130): [<ffff800010016408>]
get_cpu_fpsimd_context+0x8/0x60
[10865.163792] CPU: 31 PID: 276634 Comm: xfs_repair Not tainted 5.13.0-rc1 #1
[10865.170663] Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS
F02 08/06/2019
[10865.178054] Call trace:
[10865.180496]  dump_backtrace+0x0/0x1c0
[10865.184156]  show_stack+0x24/0x30
[10865.187467]  dump_stack+0xf8/0x164
[10865.190867]  ___might_sleep+0x174/0x250
[10865.194700]  __might_sleep+0x60/0xa0
[10865.198272]  __might_fault+0x3c/0x90
[10865.201847]  exit_robust_list+0xac/0x36c
[10865.205767]  exit_robust_list+0x9c/0x36c
[10865.209686]  futex_exit_release+0xa8/0xe4
[10865.213692]  exit_mm_release+0x28/0x44
[10865.217438]  exit_mm+0x2c/0x27c
[10865.220579]  do_exit+0x1f0/0x454
[10865.223804]  __arm64_sys_exit+0x24/0x2c
[10865.227638]  invoke_syscall+0x50/0x120
[10865.231384]  el0_svc_common.constprop.0+0x68/0x104
[10865.236172]  do_el0_svc+0x30/0x9c
[10865.239483]  el0_svc+0x2c/0x54
[10865.242538]  el0_sync_handler+0x1a4/0x1b0
[10865.246544]  el0_sync+0x19c/0x1c0


We don't reproduce this often, but the first time I've seen it was
with 'Commit: f36edc5533b2 - Merge tag 'arc-5.13-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc'

[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
[2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/05/15/303402899/build_aarch64_redhat%3A1264727321/tests/9991652_aarch64_2_console.log


Thank you,
Bruno Goncalves

