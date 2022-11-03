Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B4C4167E
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Nov 2022 19:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiKCTRV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiKCTRE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2022 15:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C21C412
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667502967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UH/aIkX3wMNUgunzs5X4yxfSBTfG/z6JG1mJwSTonGw=;
        b=C02FA6Cok6qPQGmkIfWJ2BsHhMQ4KlAa3RaffgNYX2ABZc+3sTpQot3oWCxD+lj9O6cVnv
        MbafU1bY6inEM5mehpIL+3PX2cV3E9wusmzoubfLE50qdkKA5AEad+IZ0wtdaeTUr923wa
        h+ISb5/Eb0HImiM+9kIhu46jBk09Vuk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-gHrIh6GMNTmrPILf2oQUqQ-1; Thu, 03 Nov 2022 15:16:06 -0400
X-MC-Unique: gHrIh6GMNTmrPILf2oQUqQ-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402271400b004630f3a32c3so2021419edd.15
        for <fstests@vger.kernel.org>; Thu, 03 Nov 2022 12:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH/aIkX3wMNUgunzs5X4yxfSBTfG/z6JG1mJwSTonGw=;
        b=s9d2hM2l9D4agLS990U5u+Qw3mqwriyaycFMr+gEtP445MJjSea88gLNncbkQywg8z
         S67LPxcHopSKZ0B3Zcc2z/gvC2YVJoDrOv92XaNNh0w7l6Xma+LyOYJN63+Esr+E+3oz
         MeFYFzbxQkr+ukk9am08I3fof1ilRV412UC4uNn9csb1EczDBA7iO3I0jnsBlc48OIfb
         Hcq9nBuf4PvKICmkRILLLVpCuL9xjg1SlOYddpUygXJ1hz1ZAaYdOOLSfhEnvdWD/jj1
         WohD/pn8T3Bb4UqHna1ppsL6F+9qP6mkMyL1HyHprqLM7rBeQ51uo01dh83h/Y585em8
         PYrA==
X-Gm-Message-State: ACrzQf0u516D24o5NCT84363yu9gamqMZfkDrUyrw/w8ycOeeukS0g6m
        mlLuZSLygKDyBAdpyrmBKVP2QxJg9JvWWAKBIc5lvBuVzuFJr/KdW7jme25TzWW2rGtPkXk6F5E
        /aE5rFjaUG5lOPQnUUXUEoG0RIrd8fE3FuFvTqkFfUKtwnjaCT+umS1LROi1pnh2N5mN4
X-Received: by 2002:a17:907:2bd2:b0:7ad:9ada:a6ca with SMTP id gv18-20020a1709072bd200b007ad9adaa6camr29786737ejc.637.1667502965095;
        Thu, 03 Nov 2022 12:16:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MdW+T02AhXd2aHhI9d3tTYzZmpbHtG6lHJzjn2EvQV6OeR6NbFVRhOrwzZzmo9wkXHz1ZCg==
X-Received: by 2002:a17:907:2bd2:b0:7ad:9ada:a6ca with SMTP id gv18-20020a1709072bd200b007ad9adaa6camr29786722ejc.637.1667502964878;
        Thu, 03 Nov 2022 12:16:04 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm866699edr.43.2022.11.03.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:16:04 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 0/2] generic/577: fix hash check and add metadata cleaning
Date:   Thu,  3 Nov 2022 20:14:18 +0100
Message-Id: <20221103191420.390048-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

This patchset has two fixes for generic/577. The first one is fix of
common helper _fsv_have_hash_algorithm which didn't work correctly in
generic/577 as that test requires signing. The second patch fixes issue
which is uncovered when first patch is applied. The test fails to write to file
with already enabled verity.

v1 -> v2:
- add first patch as proper fix

Andrey Albershteyn (2):
  common/verity: disable signature verification on hash alg check
  generic/577: add missing fsverity metadata cleaning

 common/verity     | 3 +++
 tests/generic/577 | 1 +
 2 files changed, 4 insertions(+)

-- 
2.31.1

