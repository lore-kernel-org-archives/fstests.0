Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16078C33C9E
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B92080A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="OcqkYiU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgAGQzw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:55:52 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36783 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgAGQzv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 11:55:51 -0500
Received: by mail-qt1-f169.google.com with SMTP id q20so340113qtp.3
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2020 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpXnwPXyr8tXDiy7kEFIiafSbEdLAqdCUWAx8vDbwjk=;
        b=OcqkYiU1R3O5YYUg7nlD6aoxU+N/bjzocElv++2M/NfqO3D2e6tDD3SgR7RQEO8yeR
         bgmiKSD0duAgsCtjTOcSiHAOprl2xFbfzdW2+/fhztBVQP/YvM0go+VlaOeKLBnfmPuh
         x//ulTisG6PE3RdPhkirr7fS+FhVEdpuBuSkcix1ywKi1ZBw5akXX7Is3vauvpKULlkA
         wTkX2y8h3zRwxpcvDGFoftMOpzadir5ljFYczN4vlEArpWmZZcDUR41bM8L8qnlToCcU
         RefatCQQAw0f34GQPRg+lA2Drb9e9fSSpBoTPwc5zY5P1s1reGc2tFvZ0qK8I5Gehqtz
         rEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpXnwPXyr8tXDiy7kEFIiafSbEdLAqdCUWAx8vDbwjk=;
        b=fdeNhtFvBShvuV+wUZKWg33Kdewrm0oSxEJUclaNkoMTd99JfB96XmOS1yHt2uWEET
         hH1ZCBmuwMr3EOo2WipgdKplIhDMS58Lt8JiHW1gUWC1cefdy11K16f3JPQTjA325xVD
         xNTzKTtlOpNfjqORkNFj78+FRmPiQMc2+9hEcGesFobGyfME2/I4NVvsrmcGQ9ljc4Xh
         zyBkx2Dp7wxYWSL8Cr9OgmR2MptTMpF6FJwpxQgYuvumDw+SeFMd79V5X1QqOC25zsDm
         a+Xa3MKPxV4EAav7BJ9PqdhkoY4Trt67hN7Kv9p6Mtlj/DU5bi+C9qQtv3UxmMskX07Y
         xZeQ==
X-Gm-Message-State: APjAAAWj+pXyCYAusKYYK8uGlt1KNq9pMVpT5HXCk+7mHpohvX1lTF8/
        NwaKn1WMVMXqFthultSrqdnTDd2kHhxhUw==
X-Google-Smtp-Source: APXvYqznW1xDrFgzzvGpdCMkFDfCDg48uFe7Li7qGGeh90gTgl6RVDd2Ln7XaUfl8V2avbdpQOwpKQ==
X-Received: by 2002:aed:256f:: with SMTP id w44mr74397881qtc.331.1578416149856;
        Tue, 07 Jan 2020 08:55:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r6sm124924qtm.63.2020.01.07.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] Some fsx improvements
Date:   Tue,  7 Jan 2020 11:55:39 -0500
Message-Id: <20200107165542.70108-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I was fixing a i_size problem in btrfs and I used fsx to reproduce the issue,
but I needed to make a few changes to actually reproduce the problem.  The
individual explanations are in the patch changelogs themselves.  One thing that
may trip people up is that I've done system("echo 3 > /proc/sys/vm/drop_caches")
for dropping caches, but this is consistent with several other tools we have in
fstests.  These are all small and straightforward fixes, and don't really affect
any of the other tests.  The only exception is generic/521 which is a soak test,
I figure we want that thing to cover as much ground as possible, so enabling the
close+open operation is desired there.  Thanks,

Josef

