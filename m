Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03BC433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Feb 2021 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EA064D9A
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Feb 2021 13:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBWN60 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:58:26 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17197 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbhBWN6Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Feb 2021 08:58:25 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2021 08:58:22 EST
ARC-Seal: i=1; a=rsa-sha256; t=1614087669; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=mx9jxu87YYQVVdMeAtP4YNzVSEbLhBFY/gOH3ATgZBwk0y0w7cFrTPrbVj/RCGR6gUIPb/BtJu84J3KJZhxWHkvGuJXQagB9l7sDeN7t8g7wYM40CGnk6wnuXg7x6mRZgdn2V82riRhpqV6iLkBAYe8ARvsJ1vpU0ML2Z3ycNg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614087669; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=24W4HXBHxHXIGqKaPYHfz6ARFM9zlxASDq5rrL/i9ow=; 
        b=mBrz0OLcEl/ZglkfeKEJ6W+j9ZVpAvti8zvxO0mroMnbApUi3IAYLLvCJ7UFhV1/pUnMdfJtJPJY2C+RaNhUDpsPU8pGECbekIA9tGUDV4lZKAPJpyqgH29bK5NDAHiu/YONjJXKLMPTm0Usjy3vniVzyhSUihImVDIS/er5by0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614087669;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=24W4HXBHxHXIGqKaPYHfz6ARFM9zlxASDq5rrL/i9ow=;
        b=OX0LfurvzXmkh1qHNP9AfxKq6YBU89YeFTABgEkVEDBMToH6lA1Ej/He+nKj3gYx
        HFYwQy8ofa4wLLSEZVaSZk2PLpQIUoO9KcDU9uylssTyrp+qJY1VjdUd3Z3liUs1w44
        5tVryxdJeQJ5FN2zzX9DsfPlf61z0jxJj/UM+s0g=
Received: from localhost.localdomain (159.75.42.226 [159.75.42.226]) by mx.zoho.com.cn
        with SMTPS id 1614087667468559.0559514007527; Tue, 23 Feb 2021 21:41:07 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210223134042.2212341-1-cgxu519@mykernel.net>
Subject: [PATCH] generic/473: fix expectation properly in out file
Date:   Tue, 23 Feb 2021 21:40:42 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It seems the expected result of testcase of "Hole + Data"
in generic/473 is not correct, so just fix it properly.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 tests/generic/473.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/473.out b/tests/generic/473.out
index 75816388..f1ee5805 100644
--- a/tests/generic/473.out
+++ b/tests/generic/473.out
@@ -6,7 +6,7 @@ Data + Hole
 1: [256..287]: hole
 Hole + Data
 0: [0..127]: hole
-1: [128..255]: data
+1: [128..135]: data
 Hole + Data + Hole
 0: [0..127]: hole
 1: [128..255]: data
--=20
2.27.0


