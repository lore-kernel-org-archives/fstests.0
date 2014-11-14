Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46977 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935260AbaKNN3N (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:29:13 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 5/7] Creates new functions for the entire environments functionality
Date: Fri, 14 Nov 2014 14:27:45 +0100
Message-Id: <1415971667-16873-5-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch contanins new functions for the environments and exports
directory with environment scripts. The most important function is
sort_tests_by_environment(), where the logic of pairing tests and
environments and sorting them happens.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/check b/check
index bdfd877..777c7a2 100755
--- a/check
+++ b/check
@@ -61,6 +61,7 @@ fi
 SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
 SRC_GROUPS="generic shared performance"
 export SRC_DIR="tests"
+export ENV_DIR="environments"
 
 usage()
 {
@@ -88,6 +89,159 @@ testlist options
 	    exit 0
 }
 
+
+# Get intersect of two lists. Can work with any list of single-worded values.
+get_lists_intersect()
+{
+	local a="$1"
+	local b="$2"
+	local intersect=""
+
+	for item in $a;do
+        if [ $(echo $b|grep -cwE "_?$item") -gt 0 ];then
+			intersect="$intersect $item"
+		fi
+	done
+	echo $intersect
+}
+
+# Get symetric difference of two lists ($1 - $2).
+# Can work with any list of single-worded values.
+# Ignore prefixing underscore
+get_lists_difference()
+{
+	local a="$1"
+	local b="$2"
+	local difference=""
+
+	a=$(echo "$a" | sed -e "s/\b_//g")
+	b=$(echo "$b" | sed -e "s/\b_//g")
+	for item in $a;do
+        if [ $(echo $b|grep -cw $item) -eq 0 ];then
+			difference="$difference $item"
+		fi
+	done
+	echo $difference
+}
+
+# Find all environments with setup files in given sour group directory.
+get_environments()
+{
+	local env_list=""
+
+	# ommit "none", this one always has to exists and we want it add later
+	env_list=$(ls $ENV_DIR|grep -v "none")
+
+	echo "none $env_list"
+}
+
+# Check if all tests passed in first argument exists in a list passed
+# as a second argument.
+environments_test_existence()
+{
+	local specified  existing
+	specified="$1"
+	existing="$2"
+
+	nonexisting=$(get_lists_difference "$specified" "$existing")
+	if [ "$nonexisting" != "" ];then
+		echo "Unknown environment(s) were passed as an argument: $nonexisting"
+		exit 1
+	fi
+}
+
+
+# Sort tests by environment.
+# Duplicate tests that are in multiple environments.
+# Write the sorted tests into $tmp.list file,
+# and their environments into $tmp.list_env
+sort_tests_by_environment()
+{
+	active_tests="$*"
+	sorted_tests=""
+	sorted_envs=""
+	include_implicit=false
+	existing_environments=$(get_environments)
+
+	required_environments="${ENVIRONMENT_LIST/,/ }"
+	excluded_environments="${XENVIRONMENT_LIST/,/ }"
+
+	# test for nonexisting required
+	environments_test_existence \
+		"$required_environments $excluded_environments" \
+		"$existing_environments"
+
+	# filter environments based on -ex or -eo arguments
+	if [ "$required_environments" = "" ];then
+		# we have no explicit list of envs, so include all
+		required_environments="$existing_environments"
+		include_implicit=true
+
+	elif [ $(echo "$required_environments"|grep -cw "none") -gt 0 ]; then
+		# If there is an explicit list, but "none" is listed there,
+		# include implicit "none" too.
+		# Otherwise "none" is ignored.
+		include_implicit=true
+
+	fi
+
+	for xenv in $excluded_environments; do
+		required_environments=$(echo "$existing_environments" |\
+			sed "s/\b$xenv\b//g")
+
+		# do not include implicit none if explicitly blocked
+		if [ "$xenv" = "none" ];then
+			include_implicit=false
+		fi
+	done
+
+	# find nonexisting requested environments in files
+	from_files=$(get_all_groups_from_file "environment")
+	nonexisting=$(get_lists_difference "$from_files" "$existing_environments")
+	if [ "$nonexisting" != "" ];then
+		echo -n  "These environments are specified in some 'environment' file,"
+		echo " but do not exists: $nonexisting"
+		exit 1
+	fi
+
+	# sort tests by explicit environments
+	for e in $required_environments; do
+		# prefix is here for differentiate between -once and -always options
+		for prefix in "" "_";do
+			# get tests for the environment from the file
+			env_tests=$(get_list_from_file "$prefix$e" "environment") 2>/dev/null
+
+			# Get all active tests that are in this environment and put it 
+			# into a list.
+			env_active_tests=$(get_lists_intersect "$env_tests" "$active_tests")
+			sorted_tests="$sorted_tests $env_active_tests"
+			count=$(echo "$env_active_tests"|wc -w)
+
+			if [ "$count" -gt 0 ];then
+				my_tmp=$(printf "$prefix$e %.0s" $(seq $count))
+				sorted_envs="$sorted_envs $my_tmp"
+			fi
+		done
+	done
+
+
+	if $include_implicit ;then
+		unused=$(get_lists_difference "$active_tests" "$sorted_tests")
+		unused_count=$(echo "$unused"|wc -w)
+		if [ "$unused_count" -gt 0 ]; then
+			sorted_tests="$unused $sorted_tests"
+			my_tmp=$(printf "none %.0s" $(seq $unused_count))
+			sorted_envs="$my_tmp $sorted_envs"
+		fi
+	fi
+
+#	printf "Sorted environments: %s\n" "$sorted_envs"
+#	printf "Count of tests: %d, environments: %d\n" \
+#		$(echo "$sorted_tests"|wc -w) $(echo "$sorted_envs"|wc -w)
+	echo "$sorted_envs" > "$tmp.list_env" 2>/dev/null
+	echo "$sorted_tests" > "$tmp.list" 2>/dev/null
+}
+
 # Get all tests tagged with specified group/environment
 # from a specified file.
 get_list_from_file()
@@ -105,6 +259,21 @@ get_list_from_file()
 	echo $grpl
 }
 
+# Get all groups/environments from a specified file.
+get_all_groups_from_file()
+{
+	file="$1"
+
+	for d in $SRC_GROUPS $FSTYP; do
+		l=$(sed -n < $SRC_DIR/$d/$file \
+			-e 's/#.*//' \
+			-e 's/$/ /' \
+			-e "s;^[0-9][0-9][0-9]\(.*\);\1;p")
+		grpl="$grpl $l"
+	done
+	echo $grpl
+}
+
 # find all tests, excluding files that are test metadata such as group files.
 # This assumes that tests are defined purely by alphanumeric filenames with no
 # ".xyz" extensions in the name.
-- 
1.9.3

