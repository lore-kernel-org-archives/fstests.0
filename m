Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FDAC00140
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Aug 2022 07:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiHBHwp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBHwo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2022 03:52:44 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C16239F
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659426761; i=@fujitsu.com;
        bh=WPV67SlE4IkQyJ0oE1D09yV6R4h+kjrR81Oonq0FFWM=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=cEI3gDOEx7GRdOsnYgVg0RY9ZJxQJaRHE0g9aaCiJJ5yejGaOf18pdi9HB+13CSeN
         ueELNccxox6utjb3XpiYguLugOkdAjromLm2xdCctByeDlmKMN9pga3p+IOw+HytTb
         yZjY6eNNYnceBsEwgXgxAYYfQf/lXRY78vXr+1Ll+LLTUDZRV8q5VOSjD00lGMT8hy
         YQ9qwEEkIyavT+73gEvGF80qVcceGquOy4oavk02vFveHoTzs4Kp1XK4geM7WyRqwi
         hc5vkLCCge5Eh74AMDuMdRjJWc/ZqVjwyXJYcl7MKb4KeTvBHK6Tgj4NwPSNUkJeYJ
         JR3V1hyI7dNJA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8OxWffk9Rd
  JBuvOKlicbtnL7sDo8XmTXABjFGtmXlJ+RQJrxqQrnAVL2Sq6v3UzNjBuZe1i5OIQEjjPKHH/
  yXq2LkZOIOcQk8SDxkyIxBFGic//JjGDJNgENCUO/H7KBGKLCMhK/J+xGsxmFpCR+NP6BKiGg
  0NYwE1i0nxZkDCLgIrErc+rGUFsXgEnifYZn9lBbAkBBYkpD98zQ8QFJU7OfMICMUZC4uCLF8
  wQNYoSM5YvZYGwKyRmzWpjgrDVJK6e28Q8gZF/FpL2WUjaFzAyrWK0TirKTM8oyU3MzNE1NDD
  QNTQ01TU20jU0MtNLrNJN1Est1S1PLS7RNdJLLC/WSy0u1iuuzE3OSdHLSy3ZxAgMyJRihbod
  jNdW/tQ7xCjJwaQkylu240WSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQnenitAOcGi1PTUirTMH
  GB0wKQlOHiURHhvngdK8xYXJOYWZ6ZDpE4x6nJ8/HNxL7MQS15+XqqUOG/jVaAiAZCijNI8uB
  GwSL3EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZjXEOQSnsy8ErhNr4COYAI6QocL7IiSRIS
  UVAOTyan3izZqWj6bJ8Rw7cN3T4HV5kxSD9WXdezb/jy/Nn5WbFqgaP2B0/a/WJQzA78dvRRf
  9XoJw3N1Qz3uZ0UX+VaaHimce9fR/pj//DgN3pqN3785Rc7panGU+zjTX7QrRPf6voz8dAlGH
  tE7eQu2l5wvWy5ya/PkNbMD5uwvrl75ds/SWfN15Vml+9YwVV77+9l0nf/RY2VmQa6x188py2
  WWt1VY+H2aKvSssr5pmnVERmeut3+WxyPeLdvvGVoYRM+UEp7R6MRWm2F8+2EmW/5Wxc/CF9Y
  uvNpQyrDW6GDVpn02vyf+Nvqb7rz4ltyydrb68pRsv3Xnp1ypuDflimqBxWr9vor9wjc/ybEo
  sRRnJBpqMRcVJwIANEYLv08DAAA=
X-Env-Sender: liuyd.fnst@fujitsu.com
X-Msg-Ref: server-23.tower-571.messagelabs.com!1659426761!6713!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24527 invoked from network); 2 Aug 2022 07:52:41 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-23.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Aug 2022 07:52:41 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 36889154
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 08:52:41 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 29B2B14C
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 08:52:41 +0100 (BST)
Received: from d94fddf05399.g08.fujitsu.local (10.167.226.82) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 2 Aug 2022 08:52:39 +0100
From:   Liu Yiding <liuyd.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <liuyd.fnst@fujitsu.com>
Subject: [PATCH] generic/688: Skip test if fs doesn't support security
Date:   Tue, 2 Aug 2022 07:52:40 +0000
Message-ID: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.82]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test require security attr. Skip test if fs doesn't support
security attr. E.g. virtiofs

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 tests/generic/688 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/688 b/tests/generic/688
index 426286b6..d11b4c21 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -7,6 +7,7 @@
 # Functional test for dropping capability bits as part of an fallocate.
 #
 . ./common/preamble
+. ./common/attr
 _begin_fstest auto prealloc quick
 
 # Override the default cleanup function.
@@ -28,6 +29,7 @@ _require_command "$GETCAP_PROG" getcap
 _require_command "$SETCAP_PROG" setcap
 _require_xfs_io_command falloc
 _require_test
+_require_attrs security
 _require_congruent_file_oplen $TEST_DIR 65536
 
 junk_dir=$TEST_DIR/$seq
-- 
2.34.1

