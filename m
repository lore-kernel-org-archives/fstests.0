Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC55BC77B7C
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjDTQWK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjDTQWF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 12:22:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B0A49CF
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 09:22:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLnio022423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=9dNDKi/1/hsBwNGoWz/GuRFI84WiL8o3MRWrSQ8FSDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=McuwUHEhEzPQE9Gb7/jHITWChaChb3HCEdbOKuX2BuNpO5gnovGIdpEc19mjradu6
         6Coj+KIGfU05Q0BClT14rSJt0NpkVKuNYuk1g8t5XGVXiMTLg8Vx4NgFJsXsGGPIB0
         KspFfulD21FWMT1wQZ+HFto0ED/hcyM/AwoFl4gLSdeG1FQ9qJPckKqChz2++4fs7P
         L/utMkyeSqveOIv1AjxZawU85yIQ19RPDN4909kPxi47rQM5JMLDscXCAoiCVCfoJP
         isgvCAmIoHUwiO2YS0SrLg8Jz7eG5aM33jsxjo/mushrfxJuJtjDLfaMcnkSW/44gq
         n532/GkzwBbEA==
Received: by cwcc.thunk.org (Postfix, from userid 0)
        id 96D9315C543A; Wed, 19 Apr 2023 23:21:42 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] test-appliance: edit out xmlns from the result.xml file
Date:   Wed, 19 Apr 2023 23:20:55 -0400
Message-Id: <20230420032056.789979-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230420032056.789979-1-tytso@mit.edu>
References: <20230420032056.789979-1-tytso@mit.edu>
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

