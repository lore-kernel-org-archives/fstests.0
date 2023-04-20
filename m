Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8987C77B73
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjDTQWJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjDTQWE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 12:22:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D44A422F
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 09:22:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLoOU022475
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=9dNDKi/1/hsBwNGoWz/GuRFI84WiL8o3MRWrSQ8FSDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fRY5wpRsR2o2Vf13MHgWa99C/W+0H4vd3zEzDYAyy5hUDhsRBquyx7AFc+hJoCvX8
         kaCJ9mEiOQGsUmZJz5AAxxax+euIDZQNyQgFmv6pIClK5Sv1x1Xm3m0EAusH6pWdxU
         1HNszvwJX+T3I59SUO0jO6Vh74kVSVZW7FirizydAotsKDBnEE+ws8Ip1/f2hef2ih
         F/hSDr+sxNeFE0vN5dEKATojF7k+SKTtb59BqgDeELGLaD4mBWWs5p0EuBhZBb3XC6
         DpWd2bVbUTIoc8Et9JUi0WeLHB1BYk2CkpjnAAzUDsKxr7vLaB8JcBlNyVu+CupcRP
         ChFCIeUW7Hj+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3167515C5441; Thu, 20 Apr 2023 12:08:40 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] test-appliance: edit out xmlns from the result.xml file
Date:   Thu, 20 Apr 2023 12:08:36 -0400
Message-Id: <20230420160837.1083228-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230420160837.1083228-1-tytso@mit.edu>
References: <20230420160837.1083228-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit b76a6cdb40b5 ("report: derive an xml schema for the xunit
report") in fstests upstream adds an xmlns attribute to the xunit
<testcase/> tag.  Unfortunately, this breaks the junitparser.py Python
package, since it uses lxml Python package, and by adding an xmlns
specifier, junitxml.py would need to know the schema and map that to
namespace tag.

So edit it out of the xml file using sed, which relies on the fact
that fstests will add the xmlns file on a single line.  The "right"
way would be to use an XSLT processor, but that would bloat the test
appliance significantly.  So we'll just cheat for now while we discuss
with fstests upstream whether adding the xmlns attribute is really
worth the pain and incompatibility that it causes.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 test-appliance/files/root/runtests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test-appliance/files/root/runtests.sh b/test-appliance/files/root/runtests.sh
index 9b32d287..c4ddb739 100755
--- a/test-appliance/files/root/runtests.sh
+++ b/test-appliance/files/root/runtests.sh
@@ -23,6 +23,7 @@ function copy_xunit_results()
 
     if test -f "$RESULT"
     then
+	sed -i.orig -e 's/xmlns=\".*\"//' "$RESULT"
 	if test -f "$RESULTS"
 	then
 	    merge_xunit "$RESULTS" "$RESULT"
-- 
2.31.0

