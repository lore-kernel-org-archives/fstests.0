Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D727EB64DD
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 20:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjGFUvr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGFUvn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 16:51:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA591FDD
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 13:51:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 366KpPkw028529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 16:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688676686; bh=BEmnUeocvfW1vEKIHyH16LmiQ8yeFKA48uaoB1AxM4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GuaTt8r0WN/LI08r1ELioJUQsH432zOJFn7hGLfLoQA+YXndiwQSvqty+4W6ib7dx
         uqOq2WsE2Gtn1kwTCiDSHf9ULlc0flqEY6OVR1daUwLbFwe0KyuFZ9vhHAy7V6touc
         Th9oHEpml2pNoFfejuA/E+d9WBZPdb5+6o7scQ8fh60t2sEAitOV57J0zkwvs/N0YD
         6haPZ8eGYmAUAonxn9o2TX4L/eauweeO8v1xfKnqP1Chd3u0s/+6oiMa8mEf5BO1QP
         6B2Oiek/agSkArQQDg614Ro37UX1eZdZZ2Ad0ReYM5kV9drm8iocer9Ccl8dvyCZEE
         C1pj1//MIFYtw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4F9F15C0295; Thu,  6 Jul 2023 16:42:34 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 2/2] report: remove xmlns specifier
Date:   Thu,  6 Jul 2023 16:42:32 -0400
Message-Id: <20230706204232.1577765-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230706204232.1577765-1-tytso@mit.edu>
References: <20230706204232.1577765-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

By specifying "xmlns=https://git.kernel.org/.../xfstests-dev.git",
this causes XML complaint parsers, such as used by the python
junitparser library, to put all of the XML elements into a namespace,
which then causes junitparser to toss its cookies.

This can be worked-around in a test runner script via:

    sed -i.orig -e 's/xmlns=\".*\"//' "$RESULT_BASE/result.xml"

but it's better not to include the xmlns line at all in the first
place, since this may cause other users of fstests who are using
the Python junitparser library a lot of headaches.

Cc: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/report | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/report b/common/report
index 3ad14f94e..081df988f 100644
--- a/common/report
+++ b/common/report
@@ -127,7 +127,6 @@ _xunit_make_section_report()
 	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
 	cat >> "$tmp_fn" << ENDL
 <testsuite
- xmlns="$fstests_ns"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="$fstests_ns $fstests_ns/tree/doc/xunit.xsd"
 
-- 
2.31.0

