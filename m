Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:52890 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaHZU3f (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 26 Aug 2014 16:29:35 -0400
From: Pavel Shilovsky <pshilovsky@samba.org>
Subject: [PATCH v2 0/3] CIFS support for XFS test suite
Date: Wed, 27 Aug 2014 00:28:35 +0400
Message-Id: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, samba-technical@samba.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

These are patches that adds CIFS support to XFS tests.

The first patch changes generic/013 test to use mount options provided for $TEST_DEV for remount. The second patch adds "-cifs" command line argument and CIFS specific variables. The third patch disables tests that need POSIX behavior from filesystem for unix cifs mounts.

With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.

Pavel Shilovsky (3):
  generic/013: encapsulate remount during cleanup
  common: add cifs support
  cifs: skip tests that need POSIX support for nounix mounts

 README            |  5 +++--
 check             |  2 ++
 common/config     | 31 +++++++++++++++++++++++++++----
 common/rc         | 39 +++++++++++++++++++++++++++++++++++++++
 tests/generic/005 |  1 +
 tests/generic/013 |  2 +-
 tests/generic/023 |  1 +
 tests/generic/024 |  1 +
 tests/generic/025 |  1 +
 tests/generic/131 |  1 +
 10 files changed, 77 insertions(+), 7 deletions(-)

-- 
1.9.1

