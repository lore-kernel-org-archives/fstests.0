Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD6C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 22:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjA3W5N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA3W5N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 17:57:13 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6A144AB
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:12 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id m12so360707qth.4
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 14:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QMggUd4v0C5OCopUWw/1HCLKWW0IuGmh1ydQ3dBFAQ=;
        b=K3g5xTKPkmL/MqDG5aZwcxTBRgfp83mpvjCumVcTzsGxOnD0b/WjkVdfEgnZd6u5hF
         lADub6f/hbDt1zarDgkDCppz0yb+wYiSMwrVyw/uc63hDUGHDBd9AeGAzaJUqCkYbg+i
         ll8bz5DyigASQSKjcoQNFb6NsqGRhoWkAK9EEToOi7rxqxl2aJGJNp0/oEN6F+SLZHUl
         Y/cuNbp8CuFdd1DcOX4NUi04vyO273OQX8++3VvKn8ugT7BjVwmat7pz2AynCO5YyW9N
         mOYVZPMtMHpUqK3dltZTOd4VphXN9Zxtp9T/Ze6YHuSW7QuZvXIkekToGR1rZ8ZRWK9k
         4X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QMggUd4v0C5OCopUWw/1HCLKWW0IuGmh1ydQ3dBFAQ=;
        b=CVL7bjGuOopiAeo4oxgNBP2+/xVvuKDHWweCq4AhXeugN50SQUF6//hqX+LSRuon6k
         gjVy7/Tm9TU2XhZfiX7Lp5YJCRKg5PBs3v5r0NX24FPg4AL+3j1QCbwtdRO/el3H2nTw
         y+iqjm0zEtYQele/JqEX68OZLuDEkGyfeIS3Yo8rwqf8qeY7YQfUWI3qbq8s+AFefLOQ
         Gz3YrKINzM8j5uQ69MoHwa0btUT21IINh9VCRkIa65wXB6GOJOrxpWYrHySZF52VJ2uu
         L3ZJwEAvNCkHXxfEpm2TRzYHDlykRyR0LxHcKiIbRzUhXRoU1+yMmgvxjMe6odSne0co
         wLrg==
X-Gm-Message-State: AO0yUKV0K5SMHfFDowb37kv7mgKJVO5hSIS7gbn8CciZ3CPU3O24gJmg
        qQp17KZMFOr3rt8zcGvBai6Xc0gMe68=
X-Google-Smtp-Source: AK7set+QleSXwakwg9ifYlvcWx6U7FPnAv3kWWanbdjjikuK4+ZQAhgK0dwazz3yKcqV7Egjq6LwMw==
X-Received: by 2002:a05:622a:174b:b0:3b8:6801:90b3 with SMTP id l11-20020a05622a174b00b003b8680190b3mr3305082qtk.0.1675119431457;
        Mon, 30 Jan 2023 14:57:11 -0800 (PST)
Received: from shiina-laptop.redhat.com ([2601:18f:47f:7270:54c1:7162:1772:f1d])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm6416332qto.96.2023.01.30.14.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:57:11 -0800 (PST)
From:   Hironori Shiina <shiina.hironori@gmail.com>
X-Google-Original-From: Hironori Shiina <shiina.hironori@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: [PATCH v3 0/2] xfs: test xfsrestore on multi-level dumpfiles with wrong root
Date:   Mon, 30 Jan 2023 17:56:41 -0500
Message-Id: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For 'xfsrestore -x', a few more tests are necessary because we hit an
issue at the cumulative mode while developing this feature:
  https://lore.kernel.org/linux-xfs/e61ae295-a331-d36a-cae1-646022dc2a6e@gmail.com/
This fix adds a few tests to run 'xfsrestore -x' to the multi-level
dumps with various file operations referencing existing tests.

Before adding the tests, a helper function to create a fake root is
added.

changes since v2:
  - Rename the new helper to `_scratch_xfs_create_fake_root` because
    this function only work for SCRATCH_DEV.
  - Skip a test if the helper fails to create a wrong root following
    existing behaviors.

changes since v1:
  - Introduce the new helper to xfs/557
  - Elaborate the background of this fix
  - Add one more test for multi-level dumps based on xfs/065

Hironori Shiina (2):
  xfs: add helper to create fake root inode
  xfs: test xfsrestore on multi-level dumpfiles with wrong root

 common/xfs        |   40 ++
 tests/xfs/545     |   31 +-
 tests/xfs/554     |   35 +-
 tests/xfs/557     |   31 +-
 tests/xfs/567     |  125 ++++
 tests/xfs/567.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/568     |  213 +++++++
 tests/xfs/568.out |  849 +++++++++++++++++++++++++
 8 files changed, 2758 insertions(+), 83 deletions(-)
 create mode 100644 tests/xfs/567
 create mode 100644 tests/xfs/567.out
 create mode 100644 tests/xfs/568
 create mode 100644 tests/xfs/568.out

-- 
2.39.1

