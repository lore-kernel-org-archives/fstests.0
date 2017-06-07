Received: from mail.sigma-star.at ([95.130.255.111]:45997 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdFGIXb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2017 04:23:31 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 1/4] Add tests for character devices
Date: Wed,  7 Jun 2017 10:20:44 +0200
Message-Id: <20170607082047.10802-2-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
References: <20170607082047.10802-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

Implement _is_char_dev similar to _is_block_dev to test for
character devices.

Add a _require_local_device test. This test is similar to
_require_block_device but checks if the path refers to a
block or a character device.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 common/rc | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/common/rc b/common/rc
index 743df427..372e313a 100644
--- a/common/rc
+++ b/common/rc
@@ -1364,6 +1364,25 @@ _is_block_dev()
     fi
 }
 
+# returns device number if a file is a character device
+#
+_is_char_dev()
+{
+	if [ $# -ne 1 ]; then
+		echo "Usage: _is_char_dev dev" 1>&2
+		exit 1
+	fi
+
+	_dev=$1
+	if [ -L "${_dev}" ]; then
+		_dev=`readlink -f "${_dev}"`
+	fi
+
+	if [ -c "${_dev}" ]; then
+		src/lstat64 "${_dev}" | $AWK_PROG '/Device type:/ { print $9 }'
+	fi
+}
+
 # Do a command, log it to $seqres.full, optionally test return status
 # and die if command fails. If called with one argument _do executes the
 # command, logs it, and returns its exit status. With two arguments _do
@@ -1792,6 +1811,23 @@ _require_block_device()
 	fi
 }
 
+# this test requires a path to refere to a local block or character device
+# $1 - device
+_require_local_device()
+{
+	if [ -z "$1" ]; then
+		echo "Usage: _require_local_device <dev>" 1>&2
+		exit 1
+	fi
+	if [ "`_is_block_dev "$1"`" != "" ]; then
+		return 0
+	fi
+	if [ "`_is_char_dev "$1"`" != "" ]; then
+		return 0
+	fi
+	_notrun "require $1 to be local device"
+}
+
 # brd based ram disks erase the device when they receive a flush command when no
 # active references are present. This causes problems for DM devices sitting on
 # top of brd devices as DM doesn't hold active references to the brd device.
-- 
2.12.3

