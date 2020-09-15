Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC1C31E49
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366B9207DE
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G02NrVvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIPAgY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:36:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726638AbgION1M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 09:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600176417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yDmsELX9CsZ63Mr3ny+tjlipxBZQVIYS1ngT09eWPc4=;
        b=G02NrVvo2RIhDolVBbkkLzOMGMEkbEdAmhONLrGtNmEhTMywA1EZsx29mGbPOwLcl5PM9j
        vWenZhL5iGTj/vJnNRHQD+SJPmvME6XuLhVTlgVVt0qA8jYpmEOXfJ+dhzxboT9EN3xqEG
        MPeWRMkj66hgQIFwqzAkLDCbtwUSmCw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-3R8Q-YdrOGiHv0dCBQouuw-1; Tue, 15 Sep 2020 09:26:55 -0400
X-MC-Unique: 3R8Q-YdrOGiHv0dCBQouuw-1
Received: by mail-wm1-f72.google.com with SMTP id u5so902617wme.3
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 06:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yDmsELX9CsZ63Mr3ny+tjlipxBZQVIYS1ngT09eWPc4=;
        b=Ph4TvFxk0GoDofvJumPIW/dfau/Bc2tQ9KwZzK/cbfFeLnSxjmSDwiOIWB4IUKXSCV
         JlzilDCl2UouptgVGrD1lEoNiXRpkKdE8NVsgBH9n5SGm72Ooi2ojyaZxFBRS5U8H1D6
         ccYiwE2YlZZEg6uqUsaCL+1O0GBf5JlbOjAFd+i81MbZvcFO6QE5ns9btc2fzcnxPIQX
         v2j5XvaFiou/z9YUfBpUXuyRUHeYWHDFlQUUzkFBLPe7X9EP51LordzG1vCep5P6LI87
         ZLqFW61Rwf1qWYhoN6t5jvwtmtdVlFygMHT/Dnh8qOURmX5BlVWIJfn57amGAkJP86mI
         qyOA==
X-Gm-Message-State: AOAM530/Zaf37qv92MFaMi1aYqCB+8vO6BUlp2iToykUYRdHDrIpKVMU
        PRYeT5TXDpfSMtz8DN5ISc+wrF+ZgNRbQLGNJr6umUbZsXyBurm7KnpFu+Covhz92vXh74SHcTV
        BTdkELGW07fuIlUkPmQ==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr4633209wme.96.1600176414145;
        Tue, 15 Sep 2020 06:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIrR+6SCUtqIKuEFj8yQPDrJQK/V4rESXolHBqDd2OI/f4uZWhJ8BVfXKqfINanIPipSUKCA==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr4633189wme.96.1600176413949;
        Tue, 15 Sep 2020 06:26:53 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id q15sm25375832wrr.8.2020.09.15.06.26.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:26:53 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 0/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Tue, 15 Sep 2020 15:26:50 +0200
Message-Id: <20200915132651.238212-1-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add test for XFS bug that corrupted metadata if extended attribute name
of length 1 was used.

V4 did the following changes:
1) replaced the system-wide cache drop and sleep by _scratch_cycle_mount
2) output of getfattr is grepped for attribute name to simplify expected
output
3) dropped explicit _check_scratch_fs
4) renamed the test from 609 to 611 - to resolve the conflict after the
recent update of master branch.

V5 did the following changes:
* dropped the the _scratch_unmount and the relevant comment

Pavel Reichl (1):
  generic: add test for boundary in xfs_attr_shortform_verify

 tests/generic/611     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/611.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 61 insertions(+)
 create mode 100755 tests/generic/611
 create mode 100644 tests/generic/611.out

-- 
2.26.2

