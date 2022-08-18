Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34867C00140
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Aug 2022 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiHRHX1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiHRHX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Aug 2022 03:23:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EEA901B2
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 00:23:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u14so682211wrq.9
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YN89IQiPuePtnogUN8hxoYWSBf1w7d4DxJZPoOSyxRQ=;
        b=osRHvR0IGDuc/JkvVP4jjZLIn1uGAXxixS12ZonynrlbJPqLadob1wotSkH8bURoGI
         ERfeV14bs9Zmc0rAovY0zeay2yR9BRH1ZpckslpRiRmqpNPbnKqo3DOj7D2YJRbRqTQk
         2m9VWoB8xn4dWM2ggNj6ImwC849VynqDRkmxUiR5b5QcsrzXrB6bNUleoyMAo0WFrnMT
         Y3pJMTmF0HQNomS76TnjLzZvE0Jl2FogynRGwpmxLB9nnY9b51JgE0l7d6sL2XH/r8AB
         Nlub8nNexvahHMtfljpnqBnKHoYmwufz6FdbZfFwNRPFwcNX6+4QmwvKvGAOfh9FEwFn
         ZIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YN89IQiPuePtnogUN8hxoYWSBf1w7d4DxJZPoOSyxRQ=;
        b=e5evQlITcQKkRhOL1S+kj6A9xgMJuFAUCfr8TP/IX+2BODyC7aiTm4OP58znYb1342
         NC5iB1q+wY+jJpmQ56Ooaei5BOgIJHtLLIwYzn46ruiqkDyXmD+paCAg4Pco63dAzZ6z
         9dK2If3X1ACp07dg1b97wU0ksjn/qm4lEOG7i9CFmueL3227bKso/gU2tssUMcBcAp4m
         2SWvWHxNnTdfpeB/zv+TcIoCs9DUkWVU19uoFguR1F/qozminEkJcP/rfYfXj2x7L5ie
         O5bSpGwdkVVGFz7g+a7WRgWvRMGvI2Lk1MAOY+KUHApfEJDdxI4lzQf9HW/rnAfLuw7b
         PCXQ==
X-Gm-Message-State: ACgBeo1Q2h3WmaL4lQoembXervD7trNGiubh3QvoYeTHgkBynJ1ozfQN
        Do5qiCR0apXC8EYPRP5h4xHc4CXX6fo=
X-Google-Smtp-Source: AA6agR7B39Yg8JQ7mo/BmVNs/V7fHehXwqmchzT3krBQ/0aBWflvtiQNVzzF6GuCfCBg5iTFZJxzWQ==
X-Received: by 2002:a05:6000:1a89:b0:222:c343:dc5b with SMTP id f9-20020a0560001a8900b00222c343dc5bmr807617wry.348.1660807402747;
        Thu, 18 Aug 2022 00:23:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021e43b4edf0sm583327wrn.20.2022.08.18.00.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:23:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org
Subject: [PATCH] Documentation: update gce-xfstests startup guide
Date:   Thu, 18 Aug 2022 10:23:18 +0300
Message-Id: <20220818072318.928812-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The instructions for setting up a Sendgrid account were
a bit out of date.  Updated the terms of the Free trial plan
and some changed setup flows.

The name of the required package python-crcmod was updated to
python3-crcmod as the former package is no longer supported.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/gce-xfstests.md | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index 2d013ab..f9da45c 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -63,12 +63,11 @@ test reports show up in your inbox once they are finished.
 
 The gce-xfstests system uses sendgrid, so if you would like to get
 e-mailed reports, you will need to sign up for a free Sendgrid
-account.  Sendgrid is designed for companies who want to do bulk
-mailings, so the free account provides 40,000 e-mails for the
-first 30 days and 100/day afterwards --- and it's highly unlikely that
-you will be running more than 100 test runs per month.  To start, visit
-the [Sendgrid website](http://www.sendgrid.com) and click on the "Start
-for Free" button. It may take a day or two
+account.  The Sendgrid free account provides 100 e-mails per day and
+it's unlikely that you will be running more than 100 test runs per day.
+
+To start, visit the [Sendgrid website](http://www.sendgrid.com) and
+click on the "Start for Free" button. It may take a day or two
 for sendgrid to decide you are a not a robot spammer, so please start
 the process right away while you familiarize yourself with the rest of
 gce-xfstests.
@@ -80,10 +79,10 @@ verify their Sender Identities before using the service. You could check
 Once you have set up a Sendgrid account, get a new API key by going to
 the url
 [https://app.sendgrid.com/settings/api_keys](https://app.sendgrid.com/settings/api_keys)
-and click on the blue "Create API Key" button and select "General API
-Key".  Pick a name such as "gce-xfstests" and enter it into the "Name
-of this key".  Then click on the Mail Send's "Full Access" bubble and
-then click on the blue "Save" button.  Copy the API key that was
+and click on the blue "Create API Key" button.
+Pick a name such as "gce-xfstests" and enter it into "API Key Name".
+Then click on the Mail Send's "Full Access" bubble and
+then click on the blue "Create & View" button.  Copy the API key that was
 generated and use it to set the `GCE_SG_API` configuration variable in
 gce-xfstests's config file.
 
@@ -126,7 +125,7 @@ https://cloud.google.com/sdk/docs/quickstart-linux
 2.  Install the following packages (debian package names
 used):
 
-        % sudo apt-get install jq xz-utils dnsutils python-crcmod
+        % sudo apt-get install jq xz-utils dnsutils python3-crcmod
 
 ## Configure gce-xfstests
 
-- 
2.25.1

