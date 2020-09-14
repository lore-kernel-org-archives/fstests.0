Return-Path: <SRS0=R9JC=CX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C1C43461
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A240206E9
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4FxyYUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINPcZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgINPcU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Sep 2020 11:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600097539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qeCgDLsI+4OQPHfbCdO6S/iZhqqRrf6tZUiVLT1VboE=;
        b=U4FxyYUa+nK2Eh3+qziGpGoDLbahoHqoFzGLy6iPY3ieO7aIm3mWN8mwiulLJNMU7MmdLr
        GqJYJV53ziXlHCqc4fdCPW2K6dzSbztAQ6ND2hHKMpklMyomncn4A+OFw+b70NTF7FcZeA
        G14391OWEx3DccC5od3yrp+YNI6prT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Cu-v2xdcNhynjNQpdGoDVg-1; Mon, 14 Sep 2020 11:32:17 -0400
X-MC-Unique: Cu-v2xdcNhynjNQpdGoDVg-1
Received: by mail-wm1-f71.google.com with SMTP id s24so144404wmh.1
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2020 08:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeCgDLsI+4OQPHfbCdO6S/iZhqqRrf6tZUiVLT1VboE=;
        b=Fn0rLkaiDcyHD5YXExj0ngzPtfUeJPzCWTB9rnn7l1rFG0lEgTytXAehvzBDbACw13
         doND3Ngy7X8rN1WDW9xjhjpCcssbS9uAKQLJPgDYXNF6tU9/f3fzXyesp/b6Qd2OlQU5
         14OWvLiJcboc5Op/OUTSuN9vnjoAXcUlDGNLrOCgfKtqZap+nE3aN82jbSEm9+Vo69dO
         JWiUKLylUlQugWhXbYC3WhNVlLf5+cXFSgBTO6Npw20D77sZ6n5lVSAlVvjh+PsSaCaC
         Vvkja7aZsTXHHLxpGBJfgdEfKCIGpor9EI7ik6tE3k1InDgtp9MtDwsEn1QXLxNPRfwl
         TWSw==
X-Gm-Message-State: AOAM533TVnmeoO+oBlGg7AFOk939AyY+axQWWvhSMm4dYbh/EgulbF3R
        /XpMj9Cy04Ol1s0iJAzdA7lwD2ZETrZe5nopgSsjKXAgrWvGnHcXbo3Klqq6sLBJYdw4eAmcVww
        8IKqaspXH2K3LsVtC+w==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr16138739wmb.135.1600097535438;
        Mon, 14 Sep 2020 08:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz33fbqiHt69Uj1DYoyk+wTCdlLeUpCNorgoMk8FYaAmeaQ8drZpglAAKjZfObLGEjJ+Wdy+A==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr16138723wmb.135.1600097535257;
        Mon, 14 Sep 2020 08:32:15 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id c14sm14000582wrm.64.2020.09.14.08.32.14
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:32:14 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 0/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Mon, 14 Sep 2020 17:32:12 +0200
Message-Id: <20200914153213.76894-1-preichl@redhat.com>
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

Pavel Reichl (1):
  generic: add test for boundary in xfs_attr_shortform_verify

 tests/generic/611     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/611.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 64 insertions(+)
 create mode 100755 tests/generic/611
 create mode 100644 tests/generic/611.out

-- 
2.26.2

