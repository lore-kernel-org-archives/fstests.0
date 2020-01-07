Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6DEC33C9E
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21DD2467A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="mh76TA6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgAGQz7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:55:59 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:45481 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgAGQz7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 11:55:59 -0500
Received: by mail-qk1-f175.google.com with SMTP id x1so43206719qkl.12
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2020 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gXoK0j6o5JMcVa6rZu5k16rvrIE/2wM67CpZGa0A70w=;
        b=mh76TA6szGegbJMJftVFs8SSnfbLS+kjaZbQE5vtxITNfg3zcpV+zR2DUunrgcppup
         WH8wGdDjsucews/RpfIy6kUCNsu+v4n70zBRaDetne6uX2telD8VAHpqChr7RmnDDsxw
         nmTV0Af88gkPJLXJsXwsveLh6KWkoGU1dsZs7tqteyCWwAKEQ1T/45N5vX7Cb3wth446
         XgrCX/yYdYDrBuc74C3sjV/ulebSJrBq2Xb9EUCxFeY4tAbwkz/H9XP/lyW3AiC2K4D8
         MWSZCZ0sXKeUNRXLTCd/fd1W1CIeeh2Uaozsz0cLSAwQpdYzINLU3heIB5kto8KbqEEZ
         S9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXoK0j6o5JMcVa6rZu5k16rvrIE/2wM67CpZGa0A70w=;
        b=gpuLF7Dmh4LeWceXhsv1ZkZjjWtbn+HSvuTnoTZSG6Dj89Jpj3UNwAy7Md5mojy61y
         9KJQcMHLJrgAgrCrCZo9AGUMpNynCeUYZvBAH/y/dcoQfV+fw0WjLV7h/0duNL+aKVN9
         xlkOVNeWxnxGt8nuTA0X34SG3FUwpDrwv12ytFb8QPTDkIRy8yqpTuMAtsTwm2EFs3LV
         lwh1rpijt4ILqIU9eCi18AW6fPj0tbKjMa6R//NgsJfDePgrms7dLD5u+uaVrPAu77UN
         k8n6HOngJlfEb5Bo+92CyUZojUAqMyaJ58g8z72EO1Kk+//Z5CmBW4i5sakk5JwCu44c
         c8BA==
X-Gm-Message-State: APjAAAV5sFcMmCDd6PRJXao0Ch5ZeX9M+/G6jPTSJAPrGWKbt3O6K6XE
        RQsAFNjIfX/tmPd1ty4PBULZk50Q32myug==
X-Google-Smtp-Source: APXvYqx76gODgKza9G1xWw0hxZZoueyXVB3me0nCe36i347x1O3tYBfNZRA0coNc4HWkn8ugPkl4wA==
X-Received: by 2002:a37:4792:: with SMTP id u140mr286706qka.100.1578416157490;
        Tue, 07 Jan 2020 08:55:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r80sm49391qke.134.2020.01.07.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] generic/521: add close+open operations to the fsx run
Date:   Tue,  7 Jan 2020 11:55:42 -0500
Message-Id: <20200107165542.70108-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107165542.70108-1-josef@toxicpanda.com>
References: <20200107165542.70108-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I was fixing a issue with i_size setting in btrfs and generic/521 was
what I used to reproduce the problem.  However I needed the close+open
operation to trigger the issue.  This is a soak test, so add this
option to increase the coverage of this test.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/521 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/521 b/tests/generic/521
index e8bc36e4..f0fc575e 100755
--- a/tests/generic/521
+++ b/tests/generic/521
@@ -52,6 +52,7 @@ fsx_args+=(-r $min_dio_sz)
 fsx_args+=(-t $min_dio_sz)
 fsx_args+=(-w $min_dio_sz)
 fsx_args+=(-Z)
+fsx_args+=(-c 10)
 
 run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
 
-- 
2.23.0

