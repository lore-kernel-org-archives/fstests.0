Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C6C00528
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGGT3r (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjGGT1q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 15:27:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C51FE7
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 12:27:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-224.bstnma.fios.verizon.net [108.26.156.224])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 367JR8UM017047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 15:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688758030; bh=a+iwoe+3nw12pV9Zhey0D2ApK0iWTCYKA9eEOkeLRyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AdOneGgSAf/RnsX4goDmTfX432e8dVMzBqNxWmq+Fv5I4xR0C9hyCFlWQm6i4QAHo
         krM+VH1vxXJmxAzetIoWEAgifiX659B+wXCA/HVbnAu2W7mkHx2sY+SRQSCEDykTTq
         TtUQeolS8QuSQOWLIe+Z04WGpEgjJVMiFj0hqLn3kstP+6StYk3/3QWnU5lzusH69J
         lT+LxRrUqSzfh5ueHLQqe2OU0aw/IEyZNnMHLDDxjOQ3GxveLbJuFYERm4dJD0+MGD
         2YQtSu9IVcDlH7WlE6bN9A4RL7ag60c2LVKCj+y2HP9Omk2fpUdQyXILLFEkXSPSLN
         nF6/kL/vszGQA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8664615C0297; Fri,  7 Jul 2023 15:27:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH -v2 2/2] report: remove xmlns specifier
Date:   Fri,  7 Jul 2023 15:27:04 -0400
Message-Id: <20230707192704.2654426-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230707192704.2654426-1-tytso@mit.edu>
References: <20230707192704.2654426-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

By specifying "xmlns=https://git.kernel.org/.../xfstests-dev.git",
this causes XML complaint parsers, such as the one used by the python
junitparser library, to put all of the XML elements into a namespace,
which then causes junitparser to toss its cookies.

This can be worked-around in a test runner script via:

    sed -i.orig -e 's/xmlns=\".*\"//' "$RESULT_BASE/result.xml"

but it's better not to include the xmlns line at all in the first
place, since this may cause other users of fstests who are using
the Python junitparser library a lot of headaches.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---

changes from v1:
  * minor updates to the commit description

 common/report | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/report b/common/report
index 3c58f0e3c..0e91e481f 100644
--- a/common/report
+++ b/common/report
@@ -128,7 +128,6 @@ _xunit_make_section_report()
 	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
 	cat >> "$tmp_fn" << ENDL
 <testsuite
- xmlns="$fstests_ns"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="$fstests_ns $fstests_ns/tree/doc/xunit.xsd"
 
-- 
2.31.0

