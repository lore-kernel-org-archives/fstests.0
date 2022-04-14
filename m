Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA4C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 23:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiDNXom (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiDNXol (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 19:44:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D58B3DD4
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so7888540ljb.2
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ff/ENWcfq5/EpyiuEKyW/jvSsOfzdN8NGcP540mzsXM=;
        b=Y80DtRQZSdhb4o3pj6hWms0Y8m3YBxHpUmyuAz1o5NqsRBV3GOCe1tQbd0FxY9X/SI
         YV+tTd1WCMUXSHud0FpJtFyVasN3LORpsDbU8Zs4B/WZofaX2k+X3tf+TUjcufyOtHil
         DHR1wRELo8hg+8tS3kFMF65j3vk2mxLJSH1+IHci522mWclOTGayRmwf02spL7W8nUi7
         zmhXwpii8I37eElUuBoGnklgiN7zJfiKtRaCiO3VgcT4ksx4l1KyCp5VpKLc5knt6cbi
         BSlOkmYEdp9jC4WgS7WJXlTfIethFCMOzve93Vdud5VaPcpnEkEDRtaS8WSQAcMgdpOf
         P7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ff/ENWcfq5/EpyiuEKyW/jvSsOfzdN8NGcP540mzsXM=;
        b=UO3DKb/8n9I0RKjOROwQoa+IcefKwBzlEijZThITt52BxuJWe9MaA+9vUB2vTWxymF
         MOKqmeEzYi94EpHz+AKd2KMKcCSnIFIYN1YQgLNLyHdhoLJoAyeN3rRFeGM4toqTEe6n
         PTtxaD71JHzESI0YMq1J2cTSi6QfdQlcQHg0ull6koUrP5UYR0JZw0L47J4NKv0PxHQs
         XkGBuu0r5ynYxytuTQMCyyD9uneOT3hA2heb47XNtlK43kL+WZhVrg8Rr/NoVEzU1ja3
         taTfo8Wzj/ZA6Zj1x6CRD3irxAQ3q4KUktqYyiYwSILikn2avkyxD1sS/hSkWSDFgLo+
         48FA==
X-Gm-Message-State: AOAM531P5UuFrc6z5fPfrUfBDIqsRC1fmwxCjm28F+2CS393KdDtGgC8
        vPxoS68ANEjtjM/sZfN7Ba0=
X-Google-Smtp-Source: ABdhPJxaQHyKGVX4NgQkfWxmDmRqUGCtdjQCR88fhAR3tKAi+qlthjTLgOf13DQ+oUhleKSAVlKvCA==
X-Received: by 2002:a05:651c:160b:b0:24d:a0fa:26cc with SMTP id f11-20020a05651c160b00b0024da0fa26ccmr1812947ljq.150.1649979733496;
        Thu, 14 Apr 2022 16:42:13 -0700 (PDT)
Received: from 5950x.telewell.oy (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e8751000000b00244beaacef1sm127548ljj.18.2022.04.14.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:42:12 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
X-Google-Original-From: Kari Argillander <kari.argillander@fidelix.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Kari Argillander <kari.argillander@fidelix.com>,
        fstests@vger.kernel.org
Subject: [xfstests-bld PATCH 0/2] Make ntfs3 more usable
Date:   Fri, 15 Apr 2022 02:42:18 +0300
Message-Id: <20220414234220.627320-1-kari.argillander@fidelix.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add ntfs3 kernel configs and disable tests which hangs at the moment.

Kari Argillander (2):
  test-appliance: Add exclude file for ntfs3
  kernel-configs: add ntfs3 to current 5.15 configs

 kernel-configs/x86_64-config-5.15                       | 3 +++
 kernel-configs/x86_64-perf-config-5.15                  | 3 +++
 kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude | 8 ++++++++
 3 files changed, 14 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude

-- 
2.35.1

