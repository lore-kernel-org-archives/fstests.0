Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2CCE7A88
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Sep 2023 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIXPOb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Sep 2023 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXPOb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Sep 2023 11:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EAB8
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695568461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=kK2IhFlJBLpYlfcOtszlJIs3MBhEawAW2wbCza8pt1M=;
        b=gp6ZTq4qSkJaggZL8DL4kyqPNklYG35KoZVQHJOEYA6tWdzI/gcmk07TTF4sm1SVnDqlFe
        WFKS6iHpYlaEqO1cTubcqK1Ndq1zlG6WeI/fgupZJHPbXV7MBSf0wez9CgaVoNgBNnYOI3
        YpS0hNgJU/d7JWDVMY3R3/Fkl8+HfUg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-LDoI3vhSPeCto_31cfNJHQ-1; Sun, 24 Sep 2023 11:14:20 -0400
X-MC-Unique: LDoI3vhSPeCto_31cfNJHQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-692779f58b2so6354128b3a.2
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695568459; x=1696173259;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kK2IhFlJBLpYlfcOtszlJIs3MBhEawAW2wbCza8pt1M=;
        b=H+yX0DQ22ldkl6mm0oHYkbwgZXJYYs1ydg1A8EE53H9Znamydtxy5TB4ozIHJjtErC
         zAJz99IWRE4pqJzWWKF19gsT1D230fmJUU7B5jV2W1sEQ5riT4po5u0VoLD+VdrlR1eW
         Ni5dZlLwohQAiw9vWit7okW6+NjyDR8AIaoMouhV7J2R7/Ib0n4g/bYixhtIpxk6ccoi
         c1oE+KAUb7YCEWOL/ZoAXbKqpM76jTwhoN9LZ5n4svr67OIu8g5VJ+Omffhkqo1cdJaW
         GzTyLVuom4QwcL5CMR42aXiZfarC+VBiTlIMNUw+dxfolDZZ7UJXdc/T1H5kLkISmjma
         x2dg==
X-Gm-Message-State: AOJu0YwFnMY+xUzxUEXdsssc9ySnkEpbRqHEa4P+XiGIFpeQnvBOj4QV
        6GDWgUEH2fr+FRowMOYT2DF5XakmhiLvOCJVVUwhHoV0m4sgYz4QWUz9IQR5ijpreSiVhLFi2Ps
        uEi9q7EpQpniJeyfeRZOmispySYmAlASRD6fX4lgMNxUrPvbQdrWJeEck1ZEu7i7XcqxtNWJF+J
        rU
X-Received: by 2002:a05:6a00:989:b0:68f:cd71:45d5 with SMTP id u9-20020a056a00098900b0068fcd7145d5mr5837581pfg.3.1695568459022;
        Sun, 24 Sep 2023 08:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl9HHSTZ56NlAZjmd7bGL079+yd4PBkoD88+tW05bmvGk5ORYaFIYafBQHqnMeS4E3iuRJVA==
X-Received: by 2002:a05:6a00:989:b0:68f:cd71:45d5 with SMTP id u9-20020a056a00098900b0068fcd7145d5mr5837560pfg.3.1695568458557;
        Sun, 24 Sep 2023 08:14:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a001d9000b00690ca67d429sm5935695pfw.100.2023.09.24.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 08:14:18 -0700 (PDT)
Date:   Sun, 24 Sep 2023 23:14:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2023.09.03 onto master branch
Message-ID: <20230924151415.yvybb7ofaywhgdna@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2023.09.03 version.

Thanks,
Zorro

The new head of the master branch is commit:

2848174358e5 xfs/559: adapt to kernels that use large folios for writes

New commits:

Bill O'Donnell (1):
      [0fc226e7eac1] fstests: generic/352 should accomodate other pwrite behaviors

Darrick J. Wong (8):
      [9445d70f0fd6] fstests: test fix for an agbno overflow in __xfs_getfsmap_datadev
      [d8008ba6d6f6] generic/650: add SOAK_DURATION controls
      [6769d7e094f2] generic/650: race mount and unmount with cpu hotplug too
      [7a2663730e69] generic/61[67]: support SOAK_DURATION
      [c5cef5ba74ed] btrfs/282: skip test if /var/lib/btrfs isnt writable
      [bfe2fd60049e] common: split _get_hugepagesize into detection and actual query
      [225170dbbc68] common: rename get_page_size to _get_page_size
      [2848174358e5] xfs/559: adapt to kernels that use large folios for writes

Jeff Layton (6):
      [6bf1570d33cc] common/attr: fix the _require_acl test
      [24f63dbc15de] generic/578: add a check to ensure that fiemap is supported
      [2fcf852d5e6c] generic/*: add a check for security attrs
      [b6f51cac4dbe] generic/294: don't run this test on NFS
      [cf1ef0daf488] generic/357: don't run this test on NFS
      [59037f2aa014] generic/187: don't run this test on NFS

Naohiro Aota (4):
      [2817df3ae9d7] aio-dio-write-verify: check for the IO errors
      [c5e4bff3a8a4] aio-dio-write-verify: print more info on the error case
      [d3bbcf20d8a2] generic/551: bail out test if aio-dio-write-verify failed
      [c1b325152870] btrfs/237: kick reclaim process with a small filesystem


Code Diffstat:

 common/attr                                |  9 +++--
 common/btrfs                               |  2 +-
 common/filter                              |  2 +-
 common/rc                                  | 19 ++++++-----
 common/verity                              |  2 +-
 src/aio-dio-regress/aio-dio-write-verify.c | 17 +++++++--
 tests/btrfs/049                            |  2 +-
 tests/btrfs/106                            |  2 +-
 tests/btrfs/173                            |  4 +--
 tests/btrfs/174                            |  2 +-
 tests/btrfs/175                            |  4 +--
 tests/btrfs/176                            |  4 +--
 tests/btrfs/192                            |  2 +-
 tests/btrfs/215                            |  2 +-
 tests/btrfs/237                            | 21 ++++++++++--
 tests/btrfs/251                            |  2 +-
 tests/btrfs/271                            |  2 +-
 tests/btrfs/274                            |  2 +-
 tests/btrfs/282                            |  7 ++++
 tests/btrfs/293                            |  2 +-
 tests/ext4/003                             |  2 +-
 tests/ext4/022                             |  2 +-
 tests/ext4/306                             |  2 +-
 tests/generic/187                          |  5 ++-
 tests/generic/270                          |  2 ++
 tests/generic/294                          |  6 ++--
 tests/generic/352                          | 10 +++---
 tests/generic/352.out                      |  6 ++--
 tests/generic/357                          |  5 +++
 tests/generic/413                          |  1 +
 tests/generic/416                          |  2 +-
 tests/generic/472                          |  2 +-
 tests/generic/495                          |  2 +-
 tests/generic/496                          |  2 +-
 tests/generic/497                          |  2 +-
 tests/generic/513                          |  2 ++
 tests/generic/551                          |  6 ++--
 tests/generic/574                          |  2 +-
 tests/generic/578                          |  1 +
 tests/generic/605                          |  1 +
 tests/generic/616                          |  3 +-
 tests/generic/617                          |  3 +-
 tests/generic/636                          |  2 +-
 tests/generic/641                          |  2 +-
 tests/generic/650                          | 18 ++++++++--
 tests/generic/675                          |  2 ++
 tests/generic/688                          |  2 ++
 tests/generic/727                          |  2 ++
 tests/xfs/513                              |  2 +-
 tests/xfs/552                              |  2 +-
 tests/xfs/559                              | 29 +++++++++++++++-
 tests/xfs/600                              | 55 ++++++++++++++++++++++++++++++
 tests/xfs/600.out                          |  2 ++
 53 files changed, 228 insertions(+), 68 deletions(-)
--
Zorro Lang
zlang@kernel.org

