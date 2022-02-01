Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6AC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Feb 2022 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiBAXT5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:19:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52634 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229626AbiBAXT5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Feb 2022 18:19:57 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 211NJivD001365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Feb 2022 18:19:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A5B2815C0040; Tue,  1 Feb 2022 18:19:44 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common: handle old versions of modprobe which don't support --help
Date:   Tue,  1 Feb 2022 18:19:36 -0500
Message-Id: <20220201231936.981003-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There exists versions of modprobe out there which are so old that
modprobe --help isn't a thing.  They're certainly not going to support
modprobe --remove-patiently, so test to make sure modprobe --help
works to suppress a spurious warning.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 405c21d40aa1 ("common/module: add patient module rmmod support")
Reported-by: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index be741c6b..cac528e8 100644
--- a/common/config
+++ b/common/config
@@ -256,7 +256,7 @@ export UDEV_SETTLE_PROG
 # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
 # modprobe removal to run forever trying to remove a module.
 MODPROBE_REMOVE_PATIENT=""
-modprobe --help | grep -q -1 "remove-patiently"
+modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"
 if [[ $? -ne 0 ]]; then
 	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
 		# We will open code our own implementation of patient module
-- 
2.31.0

