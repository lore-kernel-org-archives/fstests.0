Return-Path: <SRS0=+Qx+=Z2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B40C43603
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Dec 2019 08:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831462068E
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Dec 2019 08:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkRgd3xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLDIEe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:04:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbfLDIEd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Dec 2019 03:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575446673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yztOlW4cX8YgEAXQsJmmQenG2Twli5KV6gqc5zpUDkA=;
        b=FkRgd3xJgkUiAmproy7W5nx5zIgR8iMOkMb0OjmsjWkRvTKLcDg4DP8gij6l68PRATOesI
        9oIH9yHQcZ6tPvsp2QZpKneCkOB4ETf9RATkfM3K45N4kwgg1rPAEQDoshpiFR7aqbVVbV
        LwU+yHTPbZDCRvqNsVmbHmqZ503oa38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ilHMHsWWO5-fgxqOObZzxQ-1; Wed, 04 Dec 2019 03:04:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C18D6DBA3;
        Wed,  4 Dec 2019 08:04:28 +0000 (UTC)
Received: from dhcp-12-126.nay.redhat.com (dhcp-12-126.nay.redhat.com [10.66.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AB10600C8;
        Wed,  4 Dec 2019 08:04:27 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v1] xfs/148: fix some errors for output
Date:   Wed,  4 Dec 2019 16:04:23 +0800
Message-Id: <20191204080423.27295-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ilHMHsWWO5-fgxqOObZzxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

When disable crc, the extended attributes display is different for
"attr -l". And there is no quotes when ls no-exist file in RHEL7. eg.
RHEL7:
ls: cannot access file: No such file or directory
RHEL8:
ls: cannot access 'file': No such file or directory

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 tests/xfs/148     |  2 +-
 tests/xfs/148.out | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/xfs/148 b/tests/xfs/148
index 42cfdab0..1203edd9 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -79,7 +79,7 @@ access_stuff() {
 =09$ATTR_PROG -l $testfile
=20
 =09for name in "${test_names[@]}"; do
-=09=09ls "$testdir/f_$name"
+=09=09ls "$testdir/f_$name" 2>&1 | sed -e "s/'//g"
 =09=09$ATTR_PROG -g "a_$name" $testfile
 =09done
 }
diff --git a/tests/xfs/148.out b/tests/xfs/148.out
index c301ecb6..b1bea98a 100644
--- a/tests/xfs/148.out
+++ b/tests/xfs/148.out
@@ -4,10 +4,11 @@ f_another
 f_are_bad_for_you
 f_something
 f_too_many_beans
-Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
-Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/tes=
tfile
 Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/te=
stfile
+Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/tes=
tfile
 Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
+Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
+Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
 TEST_DIR/mount-148/testdir/f_something
 Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile=
:
 heh
@@ -20,10 +21,10 @@ heh
 TEST_DIR/mount-148/testdir/f_another
 Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
 heh
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or=
 directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or d=
irectory
 attr_get: No data available
 Could not get "a_too_many" for TEST_DIR/mount-148/testfile
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such =
file or directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such fi=
le or directory
 attr_get: No data available
 Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
 ++ ACCESSING BAD METADATA
@@ -33,18 +34,18 @@ attr_list: Structure needs cleaning
 TEST_DIR/mount-148/testdir/f_something
 Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile=
:
 heh
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many_beans': No such f=
ile or directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_too_many_beans: No such fil=
e or directory
 attr_get: No data available
 Could not get "a_too_many_beans" for TEST_DIR/mount-148/testfile
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad_for_you': No such =
file or directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad_for_you: No such fi=
le or directory
 attr_get: No data available
 Could not get "a_are_bad_for_you" for TEST_DIR/mount-148/testfile
 TEST_DIR/mount-148/testdir/f_another
 Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
 heh
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or=
 directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or d=
irectory
 attr_get: No data available
 Could not get "a_too_many" for TEST_DIR/mount-148/testfile
-ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such =
file or directory
+ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such fi=
le or directory
 Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/te=
stfile:
 heh
--=20
2.18.1

