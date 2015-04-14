Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:4711 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753927AbbDNVpP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 14 Apr 2015 17:45:15 -0400
Date: Wed, 15 Apr 2015 07:45:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Fix caller's argument for _require_command()
Message-ID: <20150414214512.GR13731@dastard>
References: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 13, 2015 at 12:32:43PM +0800, Zhaolei wrote:
> From: Zhao Lei <zhaolei@cn.fujitsu.com>
> 
> _require_command() only accept 2 arguments, first one is pure command,
> and second one is name for error message.
> 
> But some caller misused this function, for example,
>   DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>   _require_command $DEFRAG_PROG defragment
> In above code, _require_command get 4 arguments, the caller's
> second argument is never used, and the second field of first
> argument is treat as "error message" in _require_command.
> 
> We fixed above case by adding quotes to _require_command()'s
> arguments, it fixed most test case, but introduced a new bug,
> in above case, "btrfs filesystem defragment" is not a command,
> and always failed in _require_command(), it caused some testcase
> not work, as btrfs/005.
> 
> This patch fixed above caller.
> 
> Changelog v1->v2:
> 1: Add detail description, suggested by:
>    Lukáš Czerner <lczerner@redhat.com>
> 2: Add missed Reported-by.
> 3: Make $XFSDUMP_PROG always be a pure command, to avoid special
>    handling for it.

Having to change xfsdump checks means this is still the wrong fix.

_require_command should simply handle multi-part command strings.

Does the following patch fix your problems?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

common: _require_command needs to handle parameters

From: Dave Chinner <dchinner@redhat.com>

_require_command fails when a parameter based command is passed to
it, such as "xfs_io -F" or "btrfs filesystem defrag" as the command
string does not point at a binary.  Rather than hacking at all the
callers and limiting what we can do with $*_PROGS variables, just
make _require_command handle this case sanely.

Change _require_command to check for one or two variables passed to
it and to fail if none or more than 2 parameters are passed. This
will catch most cases where unquoted parameter-based commands are
passed. Further, for the command variable, the executable we need to
check for is always going to be the first token in the variable.
Hence we can simply ignore everything after the first token for the
purposes of existence and executable checks on the command.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ca8da7f..6ea107e 100644
--- a/common/rc
+++ b/common/rc
@@ -1286,10 +1286,22 @@ _require_realtime()
 # this test requires that a specified command (executable) exists
 # $1 - command, $2 - name for error message
 #
+# Note: the command string might have parameters, so strip them before checking
+# whether it is executable.
 _require_command()
 {
-    [ -n "$1" ] && _cmd="$1" || _cmd="$2"
-    [ -n "$1" -a -x "$1" ] || _notrun "$_cmd utility required, skipped this test"
+	if [ $# -eq 2 ]; then
+		_name="$2"
+	elif [ $# -eq 1 ]; then
+		_name="$1"
+	else
+		_fail "usage: _require_command <command> [<name>]"
+	fi
+
+	_command=`echo "$1" | awk '{ print $1 }'`
+	if [ ! -x $command ]; then
+		_notrun "$_name utility required, skipped this test"
+	fi
 }
 
 # this test requires the device to be valid block device
