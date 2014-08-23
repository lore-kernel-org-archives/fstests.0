Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:46337 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbaHWIQW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 23 Aug 2014 04:16:22 -0400
From: Pavel Shilovsky <pshilovsky@samba.org>
Subject: [PATCH 0/2] CIFS support for XFS test suite
Date: Sat, 23 Aug 2014 12:16:01 +0400
Message-Id: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

These are two patches that adds CIFS support to XFS tests.

The first patch adds "-cifs" command line argument and CIFS specific variables. The second patch setups a directory tree for possible CIFS specific tests.

With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.

Pavel Shilovsky (2):
  common: add cifs support
  common: add a directory tree for cifs tests

 README              |  5 +++--
 check               |  2 ++
 common/config       | 17 +++++++++++++----
 common/rc           | 33 +++++++++++++++++++++++++++++++++
 tests/cifs/Makefile | 14 ++++++++++++++
 tests/cifs/group    |  5 +++++
 tests/generic/013   |  7 ++++++-
 7 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 tests/cifs/Makefile
 create mode 100644 tests/cifs/group

-- 
1.9.1

