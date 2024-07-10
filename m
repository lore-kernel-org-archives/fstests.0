Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18082C60
	for <fstests@vger.kernel.org>; Wed, 10 Jul 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599180; cv=none; b=TQYzFG53PEpjxrKyrGZ2EoXms10bF+BcsmU0xoKgDPNYxMx4FXhExa4O8AR1+QgqrC+t3F4ianx+sqYPpNf7ZsVkgTctcwlwAyRxgQuoeAav9RwFTPpQqiHBQw3VVcA+mzv5FicUNg11FIQEtApPvV5jwz2voCtWJKGMW/fyVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599180; c=relaxed/simple;
	bh=3fQH2F+Tfu8r8+NB2/bwnzHxj0L3ZKqcohIUXkYSqEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXsi68vNKst+hcpAA5tjEtcGWDXGuXhCss5AagsSv2OwnLIaxktMTluLJ6D7COkeryy9mh4HiX6ecsXKu08H0SEPLBtn0+G6rEcE4LzN4TaLTPKY3AnFCXTFcZjbA90wmEFHKks03RuHwwxmb7GeT7sj/+45A98TwbNmTHTZq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=GrauCOaE; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="GrauCOaE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RKSSvXpclb8GYV1IOzCxk174COjsmC/eqjNqPR1ltbo=; b=GrauCOaEWejXnwzrGQ9s08qGCq
	C4dmd8SRhsGTVCkNeBD2O6y2pRTPLd3HfYe7c8tSV/3VL7oMg1ER9O83h/48VMnTvg9XpSFrhvtU6
	bMYRqL+nbiS/3210u4aNI9ANR19PY2VHvgefwphvE3ydrQICoKyBQ6e+X8wBzh15qN7TsQ+T+iHgd
	o59LCctoKDzhiUwhpkGTGvUlT3lerndPWm3Dk5yQHnGsx5MwLW3rVDUuGy6y4JjXYdgzKeTUis1SS
	59dnt86HkETLmAsyzdpIEZMYJyWh81j7EXZO+8T2g3DvgCpURnd6eWO5ZTC82gAb8g9GIUgyOKZ2Q
	yRigNXvw==;
Received: from [167.98.27.226] (helo=ct-lt-02676.office.codethink.co.uk)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1sRRqv-004FMf-Rg; Wed, 10 Jul 2024 08:35:01 +0100
From: Neill Whillans <neill.whillans@codethink.co.uk>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Neill Whillans <neill.whillans@codethink.co.uk>
Subject: [PATCH] Support for 'hostname' usage when the short name option (-s) is not available
Date: Wed, 10 Jul 2024 08:34:00 +0100
Message-ID: <20240710073400.3112068-1-neill.whillans@codethink.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: neill.whillans@codethink.co.uk

There could be systems where the only 'hostname' options available are
--help and --version, for example, when 'hostname' is provided by
coreutils. This can result in output that corrupts the expected test
output, leading to a test failure.

This commit modifies all instances of 'hostname -s' usage, to check if
the short name option is available, and if not, use only 'hostname'.

Signed-off-by: Neill Whillans <neill.whillans@codethink.co.uk>
---
 common/config  |  8 +++++++-
 common/gcov    |  8 +++++++-
 common/rc      |  9 ++++++++-
 crash/xfscrash | 13 ++++++++++---
 tools/auto-qa  |  8 +++++++-
 tools/db-walk  |  7 ++++++-
 tools/fs-walk  |  7 ++++++-
 tools/interop  |  7 ++++++-
 8 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/common/config b/common/config
index a1cd14de..9728a884 100644
--- a/common/config
+++ b/common/config
@@ -48,7 +48,13 @@ export LC_ALL=C
 
 PATH=".:$PATH"
 
-export HOST=`hostname -s`
+# If 'hostname -s' option not available, use 'hostname'
+if ! hostname -s > /dev/null 2>&1; then
+	export HOST=`hostname`
+else
+	export HOST=`hostname -s`
+fi
+
 test `uname -s` = "Linux" || _fatal "fstests only supports Linux"
 
 export MODULAR=0               # using XFS as a module or not
diff --git a/common/gcov b/common/gcov
index b7e3ed5a..3e75d765 100644
--- a/common/gcov
+++ b/common/gcov
@@ -45,9 +45,15 @@ _gcov_generate_report() {
 	# Generate a detailed HTML report from the summary
 	local gcov_start_time="$(date --date="${fstests_start_time:-now}")"
 	local genhtml=()
+  # If 'hostname -s' option not available, use 'hostname'
+  if ! hostname -s > /dev/null 2>&1; then
+	  export HOST=`hostname`
+  else
+	  export HOST=`hostname -s`
+  fi
 	if command -v genhtml > /dev/null; then
 		genhtml+=(genhtml -o "${output_dir}/" "${output_dir}/gcov.report")
-		genhtml+=(--title "fstests on $(hostname -s) @ ${gcov_start_time}" --legend)
+		genhtml+=(--title "fstests on ${HOST} @ ${gcov_start_time}" --legend)
 	fi
 
 	# Try to convert the HTML report summary as text for easier grepping if
diff --git a/common/rc b/common/rc
index 163041fe..34203c78 100644
--- a/common/rc
+++ b/common/rc
@@ -3453,8 +3453,15 @@ _full_fstyp_details()
 
 _full_platform_details()
 {
+	# If 'hostname -s' option not available, use 'hostname'
+	if ! hostname -s > /dev/null 2>&1; then
+		export HOST=`hostname`
+	else
+		export HOST=`hostname -s`
+	fi
+
      local os=`uname -s`
-     local host=`hostname -s`
+     local host=${HOST}
      local kernel=`uname -rv`
      local platform=`uname -m`
      echo "$os/$platform $host $kernel"
diff --git a/crash/xfscrash b/crash/xfscrash
index 579b724d..cc88c6fc 100755
--- a/crash/xfscrash
+++ b/crash/xfscrash
@@ -22,8 +22,15 @@ AWK_PROG=gawk
 # clear FS if >= this percent full at start of run. 100 is a good
 # number - only used on corrupt test so far
 FULL_LIMIT=80
-  
-case `hostname -s`
+
+# If 'hostname -s' option not available, use 'hostname'
+if ! hostname -s > /dev/null 2>&1; then
+	export HOST=`hostname`
+else
+	export HOST=`hostname -s`
+fi
+
+case ${HOST}
 in
     leesa)
         # mount test partition here
@@ -54,7 +61,7 @@ in
         STRESS_RANDOM=360
 	;;
     *)
-        echo "!!! no configuration data for host `hostname -s`"
+        echo "!!! no configuration data for host ${HOST}"
         exit 1
         ;;
 esac
diff --git a/tools/auto-qa b/tools/auto-qa
index 1beb2835..431c1435 100755
--- a/tools/auto-qa
+++ b/tools/auto-qa
@@ -59,7 +59,13 @@ _get_kernel_version()
 # this should be constant
 
 ROOT="$HOME/qa"
-HOST=`hostname -s`
+# If 'hostname -s' option not available, use 'hostname'
+if ! hostname -s > /dev/null 2>&1; then
+	export HOST=`hostname`
+else
+	export HOST=`hostname -s`
+fi
+
 if [ ! -z "$CVSROOT" ]; then
     export WORKAREA="$ROOT/xfs-cmds"
 else
diff --git a/tools/db-walk b/tools/db-walk
index e0992055..cb6fdc52 100755
--- a/tools/db-walk
+++ b/tools/db-walk
@@ -162,7 +162,12 @@ $device=shift @ARGV;
 die "can't read $device\n" unless (-r $device);
 die "$device is not a block device\n" unless (-b _);
 
-chomp($HOST = `hostname -s`);
+# If 'hostname -s' option not available, use 'hostname'
+if(system('hostname -s > /dev/null 2>&1')){
+	chomp($HOST = `hostname`);
+} else {
+	chomp($HOST = `hostname -s`);
+}
 
 print "*** db-walk host $HOST device $device\n";
 
diff --git a/tools/fs-walk b/tools/fs-walk
index 918e1ad6..4ff713a4 100755
--- a/tools/fs-walk
+++ b/tools/fs-walk
@@ -56,7 +56,12 @@ $dir=shift @ARGV;
 die "can't read $dir\n" unless (-r $dir);
 die "$dir is not a directory\n" unless (-d _);
 
-chomp($HOST = `hostname -s`);
+# If 'hostname -s' option not available, use 'hostname'
+if(system('hostname -s > /dev/null 2>&1')){
+	chomp($HOST = `hostname`);
+} else {
+	chomp($HOST = `hostname -s`);
+}
 
 print "*** fs-walk host $HOST dir $dir\n";
 
diff --git a/tools/interop b/tools/interop
index dc1652c2..db73dfba 100755
--- a/tools/interop
+++ b/tools/interop
@@ -63,7 +63,12 @@ sub mount($)
     run("mount -t xfs $ops $SCRATCH_DEV $SCRATCH_MNT");
 }
 
-chomp($HOST=`hostname -s`);
+# If 'hostname -s' option not available, use 'hostname'
+if(system('hostname -s > /dev/null 2>&1')){
+	chomp($HOST = `hostname`);
+} else {
+	chomp($HOST = `hostname -s`);
+}
 
 die "usage: $ARGV0 <operation> [parameters]\n" unless (scalar(@ARGV));
 print "*** $HOST: Interop started\n";
-- 
2.43.0

