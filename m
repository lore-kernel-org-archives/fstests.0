Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D55EB64DD
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHNRcH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHNRbm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 13:31:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E310D0
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 10:31:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so11662740a12.0
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692034297; x=1692639097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QSMlARCAWBLSx78cPvwOX/H672kH1RZUZeU7gv6UUk=;
        b=YCrDp/X3ONUxHQqmpQjo5uQD0vcpnlDPjezws0W16yvJHenOP9JT3f7DStgRMAzHSh
         IPw7u0+InI33hs+YuWkseCb0W70ce6Yy1FkTlFMF1hlGemvbyyswJ6uzBHhD2A4iX9ao
         dSbKPV6mx4x3h7jnaI8AuNlovsasx+AnFlooU5J84IHNF9vxi0Zrq4Wv6lqy+Pr3vppe
         DnsfWu+gNHapKNdmvsnLpzoAb3C4i4bmUG/W7+Dz6P4YWXiVRyfIB6AOQ2kFqulWUbdH
         RdImtOwKgVmQPVOe557CpBGp4If9PoapCeoziAxaANWPyZ8oQPzV8Rt76oJzWTZOOjC4
         VDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034297; x=1692639097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QSMlARCAWBLSx78cPvwOX/H672kH1RZUZeU7gv6UUk=;
        b=Em/+sPqxKbw/6/G078hoXEvOL4cP8mhUdqoYqZDivJmMNZM08LO2r1fGQR+Y7xeBHj
         vpfPTzOSX9Td6Xf224wkSdxiV1LmgYtn6tQRMazd/zWGNMxwxMO9v64Yk79+J9aA+yvm
         qViKY57Xux5DyyqR+3td/P3SOeIcGOSZdrl4fUK5GnXj3wOL7yTcFLx09rozVSYjfp5P
         0k5bojKHAZ/XkvpxVpw8wpIwWBHLOUYHXH7AtkUT04se2teer5qR3STEbwy77sy8Ceg2
         4isPp92Sh05OY/CrblL0l+1c2/I/Dl7GNMNVgsds2nrdHSIk+siLR1vttfoM+jDsI0YW
         n8Ew==
X-Gm-Message-State: AOJu0YxLpRjn7XPxtf9g4mV0aW4aAnvX7pogfKxRCP3QT2iT37l+J7uE
        wobwuA7ZN4qDdTRUcjZWOkk=
X-Google-Smtp-Source: AGHT+IFdsNiMskSRRWC7s+rh2NsQ7C5n+70621F+PiHb69P1M898M2H8j8LS37Qlx7R+iezzja3sdw==
X-Received: by 2002:a05:6402:1b1c:b0:523:b37e:b83b with SMTP id by28-20020a0564021b1c00b00523b37eb83bmr10622053edb.13.1692034297190;
        Mon, 14 Aug 2023 10:31:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402344200b00525658b7d3fsm1638988edc.45.2023.08.14.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 10:31:36 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Yuezhang Mo <Yuezhang.Mo@foxmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH v2] check: fix parsing expunge file with comments
Date:   Mon, 14 Aug 2023 20:31:32 +0300
Message-Id: <20230814173132.767345-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

commit 60054d51 ("check: fix excluded tests are only expunged in the
first iteration") change to use exclude_tests array instead of file.

The check if a test is in expunge file was using grep -q $TEST_ID FILE
so it was checking if the test was a non-exact match to one of the
lines, for a common example: "generic/001 # exclude this test" would be
a match to test generic/001.

The commit regressed this example, because the new code checks for exact
match of [ "generic/001" == "generic/001 " ]. Change the code to match a
regular expression to deal with this case and any other suffix correctly.

NOTE that the original code would have matched test generic/100 with lines
like "generic/1000" when we get to 4 digit seqnum, so the regular
expression does an exact match to the first word of the line.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Use regex for whole word match

 check | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 549725eb..71b9fbd0 100755
--- a/check
+++ b/check
@@ -592,7 +592,9 @@ _expunge_test()
 	local TEST_ID="$1"
 
 	for f in "${exclude_tests[@]}"; do
-		if [ "${TEST_ID}" == "$f" ]; then
+		# $f may contain traling spaces and comments
+		local id_regex="^${TEST_ID}\b"
+		if [[ "$f" =~ ${id_regex} ]]; then
 			echo "       [expunged]"
 			return 0
 		fi
-- 
2.34.1

