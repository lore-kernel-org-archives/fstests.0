Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C30C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiBIW0d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C849E015643
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zeuehfzhWRQTCu85g1p2aBzfFaO/AdEA/9MP3+5rnzc=; b=FDry+esVoOOcWDMPrO2VFPQogs
        ZtMtdCdjCLc/U/K6+Yx20QE2GRlnf0kBtNFW7X2zjQ+w6InU58DMqFC1fFUfc+Lg1qAezsBFTkurV
        YHFAXmJow7J9bLewoIcZQkPzOX1jx2OcVaWwiGjFqblJfW1MSF7xok0z5vJ5H9QuVki3wOo8qMucJ
        je1VUVLZL8v7nkyPJOUAcI4fw2EZ/jH3jF/nLJAqdl6Vu0CER8Teizxom+PSxvtZhdm13XEuRN3kz
        SexUXBOYmgJ98jWhi52JIglncsGL1Zjq8Ma7P8pVXGxI4AhYDjLlFexShRe6y/PmSbdKM5fE+R0o+
        PRWzP4ew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6d-2q; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 16/25] libnfs.c: fix a few simple compile warnings
Date:   Wed,  9 Feb 2022 14:26:01 -0800
Message-Id: <20220209222610.438470-17-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Like including dbench.h first so GNUSOURCE is defined and
return is not needed.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libnfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libnfs.c b/libnfs.c
index e853e47..1600701 100644
--- a/libnfs.c
+++ b/libnfs.c
@@ -17,10 +17,11 @@
    along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
 #define _FILE_OFFSET_BITS 64
-#include <thread_db.h>
+#include "dbench.h"
 #include "mount.h"
 #include "nfs.h"
 #include "libnfs.h"
+#include <thread_db.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -123,8 +124,7 @@ static data_t *recursive_lookup_fhandle(struct nfsio *nfsio, const char *name)
 	if (t != NULL) {
 		return &t->fh;
 	}
-
-	return ;
+	return NULL;
 }
 
 static data_t *lookup_fhandle(struct nfsio *nfsio, const char *name, off_t *off)
@@ -392,7 +392,6 @@ struct nfsio *nfsio_connect(const char *server, const char *export, const char *
 	mountres3 *mountres;
 	fhandle3 *fh;
         struct sockaddr_in sin;
-	int ret;
 
 	nfsio = malloc(sizeof(struct nfsio));
 	if (nfsio == NULL) {
-- 
2.34.1

