Return-Path: <fstests-owner@vger.kernel.org>
Received: from nbl-ex10-fe01.nebula.fi ([188.117.32.121]:12036 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753558AbaIVM1G (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Sep 2014 08:27:06 -0400
Message-ID: <1411388482.2869.16.camel@ari-macbook>
Subject: [PATCH 0/4] Busybox support
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 22 Sep 2014 15:21:22 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello!

The patches in this series are a result of my work to get xfstests working
on busybox in place of coreutils and friends. When xfstests is run on
a recent git version of busybox with this patchset applied, many tests
that would otherwise fail to run properly due to incompatibilities with
busybox now run. This series still works correctly with the original
programs.

It is to be noted, however, that this series does not fix everything.
There are differences in the wording of error messages between busybox
and the programs it imitates. These would have to be fixed in busybox to
match the original programs.

Ari Sundholm (4):
  common/rc: dd(): Correctly redirect stderr to stdout.
  Change all occurrences of stat --format and stat --printf to stat -c.
  generic/310: Make killall invocations not use the path to the
    executable.
  generic/100: Don't use the -R option for tar.

 common/rc         | 2 +-
 tests/generic/003 | 2 +-
 tests/generic/100 | 2 +-
 tests/generic/192 | 2 +-
 tests/generic/215 | 8 ++++----
 tests/generic/286 | 8 ++++----
 tests/generic/310 | 4 ++--
 tests/xfs/195     | 2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.1.0



