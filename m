Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C81CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860542; cv=none; b=Wov+Y3AgMJzd3sc/Xbu3Yb6X4tizhst/H2F54u1mZeiC52R3uoJKhRLCMUjtwnjxOdzy7T0zj70jZIKLJEV1Z5iNSUAzQLnjwflUDWxugj00GzdWqMKMXMgk2/vGqWAefeKl2Z0N6Dq0cOAFTydd9TLk6MQCHHiTNcW4CmnJ8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860542; c=relaxed/simple;
	bh=JqcE4S2QfNa8JiXxcYdcDZ0qnMyQ/OpacY7cVEu6n9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3cptzH9NGPPw9oe5qCA42ucL8DviQo/KQiriABP5ZLya+lsfaCtuT6ZhIXCqcPVTqYpXpHfcnP1qFiseotkAUiquPiHsIc1kq+PFMuuAUsVWgW1AyHsDC/lvhosxzWJFBCd6Urex2OB+PbEqKXSgIPZeDvlGrK7VeuxaoYzbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=x4wINhv5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="x4wINhv5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so296490b3a.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860540; x=1745465340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO3+1mSUf+I7vZURFqMsjrVPgOhEjJ6SNSD3dCSvJOo=;
        b=x4wINhv5JabfdkRg330T1IEhq8/WsnYB7zRYM6OniyIVktxFsPHlHbCK2Ct4g8mIwQ
         7bK/vDIZ9LniZXUGkeF6LMggJYmRZGcCRVxXnR4lkcjXleOndH7LHdEuciVfiRrMsxXx
         RL73Hrz5zZydpD4Li3NPN3yxtox8UVwLge7/EJTah/8QzQX7MTB7FzNKdNzECPCmzLuV
         aQeqSWv9YiKIqjdmzMLN7up0p19MT6nElLlLbdXMg3rkRqXmI/Pl/CSDQdf/3yomqkwe
         5vhRUItKTQJtnYhXWRrV9rpkW6xlrFhVDnNbF7ZmNMlMgWjNEwU0QVKhqsP2Vu6aj9XF
         IzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860540; x=1745465340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO3+1mSUf+I7vZURFqMsjrVPgOhEjJ6SNSD3dCSvJOo=;
        b=qEYhLXMnbRLNh3kCKwiXmjA6vdKW2oaH7fYV/cWj0C+BPwrTvnoJBPJjL2uIdIJKoM
         nnD1geYfusfnwXtz1AYzj/mV+5A475ZpbsFQz3nPqTG6LW1mGZ5WQnvak+sOm7FdHG2t
         ma2fuD4BzCl4LkfzGIDXbIztXMt0oH3XMRVeae/n+lJVcQ2GK17d0skeEtoBxdzrK+19
         DR3SQpM4Zle7xyPO+rjMS8By/I1JtMZEk0G1+O8E73NI1TshihRhcBxKYtYoNd3FOQ8n
         Bn2CCXUL7YqE8JLJTIc1HLna9p1Fx57WeK9ZINp6GsLUtHTEnH6haRhK14tG6HCXUYGT
         Zo4w==
X-Gm-Message-State: AOJu0YwX5BiVt2WNVyP53DkRhIJ29/U44MHTvicd/IWDIG+RUoGuu2Li
	Fvflo/zda8XXAkfQl4gH6o/soytXYxJe32VZVUi1TFQOjoqoBNpHiP3GVy1xos7cQc/GdJU6+/D
	w
X-Gm-Gg: ASbGncuDD6OHFiai8bNu11XhfMwVtN7R0Zdp+8yZVqcta1Q3CVnGAAV1sMAh6hyrHjj
	k9PNWeMHzkAIEy3Ar30Ln5LLrT4tze4lfhMINYUhvmuz9UIFM0YGRx9mhme29cBO+Wz5A5eUuia
	2fjn9TTsH93QVQaBmMuHIcIZRaTlw2+Vzhd7HeWNpawAtj0TBfwdBzLu/7eUEIf0ZyFPgYRSCXX
	HX+N0o1tfBbMpht/RNmdQDnpEMhHXkIRVygFC4AlkAAK9yzHfX94BXD+6+3o7lsqXFV1LDfuOm6
	whIamARL3ddmPD79eG5g3+dV2te7mj2NeT18s0pg6ceYGDdHHJvLwAqymZvrUEa4MTKltVNgpy7
	Hdw==
X-Google-Smtp-Source: AGHT+IF0JB0sSVLZ9AK/8yLE3MF9MUU6DsbUjSKorpa6aDpCONAw1AXQjU/Eaj1EeF9ZC42R6aZCAQ==
X-Received: by 2002:a05:6a00:21c4:b0:735:d89c:4b8e with SMTP id d2e1a72fcca58-73c266beeabmr5801447b3a.5.1744860540113;
        Wed, 16 Apr 2025 20:29:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c62f7sm11567361b3a.65.2025.04.16.20.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:28:59 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YA9-1GpL;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEu-2A3F;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 13/28] check-parallel: introduce config file support
Date: Thu, 17 Apr 2025 13:00:54 +1000
Message-ID: <20250417031208.1852171-14-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

check-parallel will use the same config file format check does,
and use the same code to auto-discover the config file.

The biggest difference is that check-parallel -requires- the use
of config sections, and the first section *must* be named
"[check-parallel]". This first section is used for defining
setup parameters for check parallel - loop device image file sizes,
etc.

The second biggest difference is that check-parallel does not allow
the config file to define devices. Any section found to contain a
device definition such as TEST_DEV or SCRATCH_DEV will result
check-parallel terminating with an error.

This config file format works for check-parallel invoking check,
too, because once a section is specified on the check command line,
it effectively ignores unknown values set in sections that it
doesn't run.  Hence it effectively skips over the [check-parallel]
setup section.

For check-parallel, each config section now defines just the
filesystem configuration to be tested; all the usual mount and mkfs
options apply, and USE_EXTERNAL must be set for testing external
devices.

This commit implements the initial [check-parallel] section support
and moves the build in default values for these parameters to the
config file setup. This means if the config file does not contain
all the necessary parameter values, a default value will be used for
it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check-parallel         | 14 +++-----
 common/config-sections | 78 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/check-parallel b/check-parallel
index 5bb44b6a5..6fc86fb92 100755
--- a/check-parallel
+++ b/check-parallel
@@ -15,22 +15,14 @@ runner_list=()
 runtimes=()
 show_test_list=
 run_section=""
+iam="check-parallel"
 
 tmp=/tmp/check-parallel.$$
 
-TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
-TEST_RTDEV_SIZE=${TEST_RTDEV_SIZE:=10G}
-TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
-SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
-SCRATCH_RTDEV_SIZE=${SCRATCH_RTDEV_SIZE:=20G}
-SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SIZE:=512M}
-LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
-
-FSTYP=
-
 . ./common/exit
 . ./common/test_names
 . ./common/test_list
+. ./common/config-sections
 
 usage()
 {
@@ -332,6 +324,8 @@ cleanup()
 
 trap "cleanup; exit" HUP INT QUIT TERM
 
+_config_setup_parallel
+
 split_runner_list
 if [ -n "$show_test_list" ]; then
 	echo Time ordered test list:
diff --git a/common/config-sections b/common/config-sections
index 69a03375a..28bd11bab 100644
--- a/common/config-sections
+++ b/common/config-sections
@@ -329,6 +329,7 @@ get_next_config() {
 
 known_hosts()
 {
+	[ -z "$HOST" ] && export HOST=`hostname -s`
 	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
 
 	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
@@ -336,7 +337,7 @@ known_hosts()
 	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config
 }
 
-_config_section_setup()
+_config_file_setup()
 {
 	if [ ! -f "$HOST_OPTIONS" ]; then
 		known_hosts
@@ -346,13 +347,32 @@ _config_section_setup()
 	export OPTIONS_HAVE_SECTIONS=false
 	if [ -f "$HOST_OPTIONS" ]; then
 		export HOST_OPTIONS_SECTIONS=`get_config_sections $HOST_OPTIONS`
-		if [ -z "$HOST_OPTIONS_SECTIONS" ]; then
-			. $HOST_OPTIONS
-			export HOST_OPTIONS_SECTIONS="-no-sections-"
-		else
+		if [ -n "$HOST_OPTIONS_SECTIONS" ]; then
 			export OPTIONS_HAVE_SECTIONS=true
 		fi
 	fi
+}
+
+_config_section_setup()
+{
+	if [ "$iam" == "check-parallel" ]; then
+		echo "$iam: incorrect config file format chosen!"
+		exit 1;
+	fi
+
+	_config_file_setup
+
+	# If we don't have sections, source the options from the config file.
+	# Otherwise, strip sections that should not be run by check that may be
+	# present in the config file
+	if [ "$OPTIONS_HAVE_SECTIONS" != "true" ]; then
+		. $HOST_OPTIONS
+		export HOST_OPTIONS_SECTIONS="-no-sections-"
+	else
+		export HOST_OPTIONS_SECTIONS=$(echo $HOST_OPTIONS_SECTIONS | \
+				sed -e 's/check-parallel//')
+	fi
+
 
 	if [ -z "$CONFIG_INCLUDED" ]; then
 		get_next_config `echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
@@ -388,3 +408,51 @@ _config_section_setup()
 		fi
 	fi
 }
+
+# check-parallel config files must:
+# 1. have config sections defined
+# 2. use the first config section for check-parallel setup
+# 3. not define any physical device parameter in any section
+#
+# If all these are true, then we read the first section that defines
+# the check-parallel config parameters and continue onwards.
+_config_setup_parallel()
+{
+	if [ "$iam" != "check-parallel" ]; then
+		echo "$iam: incorrect config file format chosen!"
+		exit 1;
+	fi
+
+	_config_file_setup
+
+	if [ "$OPTIONS_HAVE_SECTIONS" != "true" ]; then
+		echo "$iam config file has no sections!"
+		exit 1;
+	fi
+
+	local first_section=`echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
+	if [ "$first_section" != "$iam" ]; then
+		echo "$iam config file has no [$iam] section"
+		exit 1
+	fi
+
+	grep DEV $HOST_OPTIONS |grep -qv SIZE
+	if [ $? -ne 1 ]; then
+		echo "$iam config file has devices defined"
+		exit 1
+	fi
+
+	# we only need to pull in the config parameters here and set defaults
+	# if they are not set after pulling in the config values.
+	parse_config_section $1
+
+	TEST_DEV_SIZE=${TEST_DEV_SIZE:=10G}
+	TEST_RTDEV_SIZE=${TEST_RTDEV_SIZE:=10G}
+	TEST_LOGDEV_SIZE=${TEST_LOGDEV_SIZE:=128M}
+	SCRATCH_DEV_SIZE=${SCRATCH_DEV_SIZE:=20G}
+	SCRATCH_RTDEV_SIZE=${SCRATCH_RTDEV_SIZE:=20G}
+	SCRATCH_LOGDEV_SIZE=${SCRATCH_LOGDEV_SIZE:=512M}
+	LOGWRITES_DEV_SIZE=${LOGWRITES_DEV_SIZE:=2G}
+
+	FSTYP=${FSTYP:=xfs}
+}
-- 
2.45.2

