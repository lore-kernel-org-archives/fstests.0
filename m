Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB9C07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C963761C33
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGGWfN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230189AbhGGWfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 18:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625697151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9cq4qh1THv3w9p1SB384WT0hkLNDoDTI6vvx3heu/WY=;
        b=hFZ/iIIvd4T5/EySMEA8oVguyIFfc0J13OYnLoYS4Rz96P9ZGhcD2mmFKeENYbZnDq2Y0L
        kUNV2wbfZRBtstLXxSLx7/H6H3IqZuZVsiJl6dPGOVYsvMIt8lyLHVM/NrFzVTMXwNZlYu
        qVskkmj6B+cjraH5T8qC1YdYbhA8cEc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-CLWisnbeNPa8nl94McK5eQ-1; Wed, 07 Jul 2021 18:32:30 -0400
X-MC-Unique: CLWisnbeNPa8nl94McK5eQ-1
Received: by mail-ej1-f71.google.com with SMTP id d2-20020a1709072722b02904c99c7e6ddfso1103343ejl.15
        for <fstests@vger.kernel.org>; Wed, 07 Jul 2021 15:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cq4qh1THv3w9p1SB384WT0hkLNDoDTI6vvx3heu/WY=;
        b=TcSEnGxI0njmbhmnaIIsmWOi4olqPT249AsUMNJSu4AJPEk9dukQtTX9Lit8psQI6B
         +UCdrkTarrDat4UzI0mOU/Z4kV/ImX9tI1wKvx+PqQm8F4FAscfHuhPlFIuwJGhPzmmf
         4LYmIdgzHmUxwZNG4J8/icnpsZKix+9fX8L42K80o9jDTpcCIvL/U0XjJ22J03cM0Oit
         qHuoITl7dH227KeS/zZzOZb1ovBHDvFoAb+JKrd8kJRb4AtPcLByxsh8wU4F+BaPfq21
         vKl4hM3e6ec70G1BiMfNaAkeITI6tX5+ZhtFMY47wfSasyojDWA/Tsz80WWb52zDEfdQ
         dIJg==
X-Gm-Message-State: AOAM5301BN5cchZKFSo2rTSxTKnm0Io35idkpOATHthfZyYkdupdyEl0
        YZuI4RmVBRb1AjD+uXXxjh2oN/d/XpXRZsVHtTZzyLEnL/xzrl9RkLEGOXN0Mckgpf76w7bO9XR
        BHxpHJJTROCsFdLrC+FFhpMPCyf4mYIT5WKlUIbdUoAP+7KShW1LrUlvLR+kMZMATLs/+
X-Received: by 2002:a17:906:c208:: with SMTP id d8mr26814425ejz.67.1625697149066;
        Wed, 07 Jul 2021 15:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRs+n/0aB2aZO9xVIK80FMrHQ9XB4Tz85De2RSfcBieAnCGJKGCrdPiapQ+MU4zeos5h8CcQ==
X-Received: by 2002:a17:906:c208:: with SMTP id d8mr26814408ejz.67.1625697148859;
        Wed, 07 Jul 2021 15:32:28 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id ze15sm54158ejb.79.2021.07.07.15.32.28
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 15:32:28 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 0/1] generic/{453,454}: Do NOT run for FSs restricting names
Date:   Thu,  8 Jul 2021 00:32:26 +0200
Message-Id: <20210707223227.32053-1-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

this is a quick attempt to finish what was discussed in thread:
	generic/453: Exclude filenames that are not supported by exfat
	https://www.spinics.net/lists/fstests/msg16328.html

Based on Darrick's comments:

"""
TBH I think these tests (g/453 and g/454) are probably only useful for
filesystems that allow unrestricted byte streams for names.
"""

and_require_names_are_bytes()

"""
Nowadays with wider testing of other filesystems (thanks, Red Hat!) we
should hide these behind _require_names_are_bytes or move them to
tests/xfs/.
"""

Changes in V2:
* Added description for _require_names_are_bytes()
* Added _require_names_are_bytes() to g/454 as well
* fixed typo s/now/not/

Pavel Reichl (1):
  generic/{453,454}: Don't run for FSs restricting names

 common/rc         | 13 +++++++++++++
 tests/generic/453 |  1 +
 tests/generic/454 |  1 +
 3 files changed, 15 insertions(+)

-- 
2.31.1

