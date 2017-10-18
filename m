Received: from mail-qt0-f175.google.com ([209.85.216.175]:54175 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdJRU6z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2017 16:58:55 -0400
Received: by mail-qt0-f175.google.com with SMTP id n61so11993437qte.10
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2017 13:58:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2][v3] fstests: add fio perf results support
Date: Wed, 18 Oct 2017 16:58:51 -0400
Message-Id: <1508360332-12033-1-git-send-email-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: kernel-team@fb.com, david@fromorbit.com, fstests@vger.kernel.org, tytso@mit.edu, eguan@redhat.com, darrick.wong@oracle.com
Cc: Josef Bacik <jbacik@fb.com>
List-ID: <fstests@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

This patch does the nuts and bolts of grabbing fio results and storing
them in a database in order to check against for future runs.  This
works by storing the results in resuts/fio-results.db as a sqlite
database.  The src/perf directory has all the supporting python code for
parsing the fio json results, storing it in the database, and loading
previous results from the database to compare with the current results.

This also adds a PERF_CONFIGNAME option that must be set for this to
work.  Since we all have various ways we run fstests it doesn't make
sense to compare different configurations with each other (unless
specifically desired).  The PERF_CONFIGNAME will allow us to separate
out results for different test run configurations to make sure we're
comparing results correctly.

Currently we only check against the last perf result.  In the future I
will flesh this out to compare against the average of N number of runs
to be a little more complete, and hopefully that will allow us to also
watch latencies as well.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
v2->v3:
- fixed FioResultDecoder.py so it would translate from older versions of fio
  properly
- fixed FioCompare.py to be a bit more verbose so we know things are working or
  what goes wrong when it isn't.
- fixed fio-insert-and-compare.py so it grabbed the last resulte _before_ we
  insert a new result.
- fixed generate-schema.py to generate an updated schema, including not using
  NOT NULL for all of the fields in case we have some missing fields from older
  versions of fio that we don't care about.
- updated fio-results.sql with the new schema.

v1->v2:
- moved helpers into common/perf
- changed the python stuff to specifically use python2 since that's the lowest
  common demoninator

 .gitignore                         |   1 +
 common/config                      |   2 +
 common/perf                        |  41 ++++++++++++++
 src/perf/FioCompare.py             | 112 +++++++++++++++++++++++++++++++++++++
 src/perf/FioResultDecoder.py       |  62 ++++++++++++++++++++
 src/perf/ResultData.py             |  43 ++++++++++++++
 src/perf/fio-insert-and-compare.py |  35 ++++++++++++
 src/perf/fio-results.sql           |  94 +++++++++++++++++++++++++++++++
 src/perf/generate-schema.py        |  55 ++++++++++++++++++
 9 files changed, 445 insertions(+)
 create mode 100644 common/perf
 create mode 100644 src/perf/FioCompare.py
 create mode 100644 src/perf/FioResultDecoder.py
 create mode 100644 src/perf/ResultData.py
 create mode 100644 src/perf/fio-insert-and-compare.py
 create mode 100644 src/perf/fio-results.sql
 create mode 100644 src/perf/generate-schema.py

diff --git a/.gitignore b/.gitignore
index ae7ef87ab384..986a6f7ff0ad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
 /src/log-writes/replay-log
+/src/perf/*.pyc
 
 # dmapi/ binaries
 /dmapi/src/common/cmd/read_invis
diff --git a/common/config b/common/config
index 71798f0adb1e..f6226d85bc10 100644
--- a/common/config
+++ b/common/config
@@ -195,6 +195,8 @@ export MAN_PROG="`set_prog_path man`"
 export NFS4_SETFACL_PROG="`set_prog_path nfs4_setfacl`"
 export NFS4_GETFACL_PROG="`set_prog_path nfs4_getfacl`"
 export UBIUPDATEVOL_PROG="`set_prog_path ubiupdatevol`"
+export PYTHON2_PROG="`set_prog_path python2`"
+export SQLITE3_PROG="`set_prog_path sqlite3`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/perf b/common/perf
new file mode 100644
index 000000000000..b9b4f79c5edc
--- /dev/null
+++ b/common/perf
@@ -0,0 +1,41 @@
+#
+# Common perf specific functions
+#
+
+
+_require_fio_results()
+{
+	if [ -z "$PERF_CONFIGNAME" ]
+	then
+		_notrun "this test requires \$PERF_CONFIGNAME to be set"
+	fi
+	_require_command $PYTHON2_PROG python2
+
+	$PYTHON2_PROG -c "import sqlite3" >/dev/null 2>&1
+	[ $? -ne 0 ] && _notrun "this test requires python sqlite support"
+
+	$PYTHON2_PROG -c "import json" >/dev/null 2>&1
+	[ $? -ne 0 ] && _notrun "this test requires python json support"
+
+	_require_command $SQLITE3_PROG sqlite3
+}
+
+_fio_results_init()
+{
+	cat $here/src/perf/fio-results.sql | \
+		$SQLITE3_PROG $RESULT_BASE/fio-results.db
+	[ $? -ne 0 ] && _fail "failed to create results database"
+	[ ! -e $RESULT_BASE/fio-results.db ] && \
+		_fail "failed to create results database"
+}
+
+_fio_results_compare()
+{
+	_testname=$1
+	_resultfile=$2
+
+	run_check $PYTHON2_PROG $here/src/perf/fio-insert-and-compare.py \
+		-c $PERF_CONFIGNAME -d $RESULT_BASE/fio-results.db \
+		-n $_testname $_resultfile
+}
+
diff --git a/src/perf/FioCompare.py b/src/perf/FioCompare.py
new file mode 100644
index 000000000000..9ab89e7463b3
--- /dev/null
+++ b/src/perf/FioCompare.py
@@ -0,0 +1,112 @@
+default_keys = [ 'iops', 'io_bytes', 'bw' ]
+latency_keys = [ 'lat_ns_min', 'lat_ns_max' ]
+main_job_keys = [ 'sys_cpu', 'elapsed' ]
+io_ops = ['read', 'write', 'trim' ]
+
+def _fuzzy_compare(a, b, fuzzy):
+    if a == b:
+        return 0
+    if a == 0:
+        return 100
+    a = float(a)
+    b = float(b)
+    fuzzy = float(fuzzy)
+    val = ((b - a) / a) * 100
+    if val > fuzzy or val < -fuzzy:
+        return val;
+    return 0
+
+def _compare_jobs(ijob, njob, latency, fuzz):
+    failed = 0
+    for k in default_keys:
+        for io in io_ops:
+            key = "{}_{}".format(io, k)
+            comp = _fuzzy_compare(ijob[key], njob[key], fuzz)
+            if comp < 0:
+                print("    {} regressed: old {} new {} {}%".format(key,
+                      ijob[key], njob[key], comp))
+                failed += 1
+            elif comp > 0:
+                print("    {} improved: old {} new {} {}%".format(key,
+                      ijob[key], njob[key], comp))
+            else:
+                print("{} is a-ok {} {}".format(key, ijob[key], njob[key]))
+    for k in latency_keys:
+        if not latency:
+            break
+        for io in io_ops:
+            key = "{}_{}".format(io, k)
+            comp = _fuzzy_compare(ijob[key], njob[key], fuzz)
+            if comp > 0:
+                print("    {} regressed: old {} new {} {}%".format(key,
+                      ijob[key], njob[key], comp))
+                failed += 1
+            elif comp < 0:
+                print("    {} improved: old {} new {} {}%".format(key,
+                      ijob[key], njob[key], comp))
+            else:
+                print("{} is a-ok {} {}".format(key, ijob[key], njob[key]))
+    for k in main_job_keys:
+        comp = _fuzzy_compare(ijob[k], njob[k], fuzz)
+        if comp > 0:
+            print("    {} regressed: old {} new {} {}%".format(k, ijob[k],
+                  njob[k], comp))
+            failed += 1
+        elif comp < 0:
+            print("    {} improved: old {} new {} {}%".format(k, ijob[k],
+                  njob[k], comp))
+        else:
+                print("{} is a-ok {} {}".format(k, ijob[k], njob[k]))
+    return failed
+
+def compare_individual_jobs(initial, data, fuzz):
+    failed = 0;
+    initial_jobs = initial['jobs'][:]
+    for njob in data['jobs']:
+        for ijob in initial_jobs:
+            if njob['jobname'] == ijob['jobname']:
+                print("  Checking results for {}".format(njob['jobname']))
+                failed += _compare_jobs(ijob, njob, fuzz)
+                initial_jobs.remove(ijob)
+                break
+    return failed
+
+def default_merge(data):
+    '''Default merge function for multiple jobs in one run
+
+    For runs that include multiple threads we will have a lot of variation
+    between the different threads, which makes comparing them to eachother
+    across multiple runs less that useful.  Instead merge the jobs into a single
+    job.  This function does that by adding up 'iops', 'io_kbytes', and 'bw' for
+    read/write/trim in the merged job, and then taking the maximal values of the
+    latency numbers.
+    '''
+    merge_job = {}
+    for job in data['jobs']:
+        for k in main_job_keys:
+            if k not in merge_job:
+                merge_job[k] = job[k]
+            else:
+                merge_job[k] += job[k]
+        for io in io_ops:
+            for k in default_keys:
+                key = "{}_{}".format(io, k)
+                if key not in merge_job:
+                    merge_job[key] = job[key]
+                else:
+                    merge_job[key] += job[key]
+            for k in latency_keys:
+                key = "{}_{}".format(io, k)
+                if key not in merge_job:
+                    merge_job[key] = job[key]
+                elif merge_job[key] < job[key]:
+                    merge_job[key] = job[key]
+    return merge_job
+
+def compare_fiodata(initial, data, latency, merge_func=default_merge, fuzz=5):
+    failed  = 0
+    if merge_func is None:
+        return compare_individual_jobs(initial, data, fuzz)
+    ijob = merge_func(initial)
+    njob = merge_func(data)
+    return _compare_jobs(ijob, njob, latency, fuzz)
diff --git a/src/perf/FioResultDecoder.py b/src/perf/FioResultDecoder.py
new file mode 100644
index 000000000000..e15406f89819
--- /dev/null
+++ b/src/perf/FioResultDecoder.py
@@ -0,0 +1,62 @@
+import json
+
+class FioResultDecoder(json.JSONDecoder):
+    """Decoder for decoding fio result json to an object for our database
+
+    This decodes the json output from fio into an object that can be directly
+    inserted into our database.  This just strips out the fields we don't care
+    about and collapses the read/write/trim classes into a flat value structure
+    inside of the jobs object.
+
+    For example
+        "write" : {
+            "io_bytes" : 313360384,
+            "bw" : 1016,
+        }
+
+    Get's collapsed to
+
+        "write_io_bytes" : 313360384,
+        "write_bw": 1016,
+
+    Currently any dict under 'jobs' get's dropped, with the exception of 'read',
+    'write', and 'trim'.  For those sub sections we drop any dict's under those.
+
+    Attempt to keep this as generic as possible, we don't want to break every
+    time fio changes it's json output format.
+    """
+    _ignore_types = ['dict', 'list']
+    _override_keys = ['lat_ns', 'lat']
+    _io_ops = ['read', 'write', 'trim']
+
+    _transform_keys = { 'lat': 'lat_ns' }
+
+    def decode(self, json_string):
+        """This does the dirty work of converting everything"""
+        default_obj = super(FioResultDecoder, self).decode(json_string)
+        obj = {}
+        obj['global'] = {}
+        obj['global']['time'] = default_obj['time']
+        obj['jobs'] = []
+        for job in default_obj['jobs']:
+            new_job = {}
+            for key,value in job.iteritems():
+                if key not in self._io_ops:
+                    if value.__class__.__name__ in self._ignore_types:
+                        continue
+                    new_job[key] = value
+                    continue
+                for k,v in value.iteritems():
+                    if k in self._override_keys:
+                        if k in self._transform_keys:
+                            k = self._transform_keys[k]
+                        for subk,subv in v.iteritems():
+                            collapsed_key = "{}_{}_{}".format(key, k, subk)
+                            new_job[collapsed_key] = subv
+                        continue
+                    if v.__class__.__name__ in self._ignore_types:
+                        continue
+                    collapsed_key = "{}_{}".format(key, k)
+                    new_job[collapsed_key] = v
+            obj['jobs'].append(new_job)
+        return obj
diff --git a/src/perf/ResultData.py b/src/perf/ResultData.py
new file mode 100644
index 000000000000..f0c7eace6dad
--- /dev/null
+++ b/src/perf/ResultData.py
@@ -0,0 +1,43 @@
+import sqlite3
+
+def _dict_factory(cursor, row):
+    d = {}
+    for idx,col in enumerate(cursor.description):
+        d[col[0]] = row[idx]
+    return d
+
+class ResultData:
+    def __init__(self, filename):
+        self.db = sqlite3.connect(filename)
+        self.db.row_factory = _dict_factory
+
+    def load_last(self, testname, config):
+        d = {}
+        cur = self.db.cursor()
+        cur.execute("SELECT * FROM fio_runs WHERE config = ? AND name = ?ORDER BY time DESC LIMIT 1",
+                    (config,testname))
+        d['global'] = cur.fetchone()
+        if d['global'] is None:
+            return None
+        cur.execute("SELECT * FROM fio_jobs WHERE run_id = ?",
+                    (d['global']['id'],))
+        d['jobs'] = cur.fetchall()
+        return d
+
+    def _insert_obj(self, tablename, obj):
+        keys = obj.keys()
+        values = obj.values()
+        cur = self.db.cursor()
+        cmd = "INSERT INTO {} ({}) VALUES ({}".format(tablename,
+                                                       ",".join(keys),
+                                                       '?,' * len(values))
+        cmd = cmd[:-1] + ')'
+        cur.execute(cmd, tuple(values))
+        self.db.commit()
+        return cur.lastrowid
+
+    def insert_result(self, result):
+        row_id = self._insert_obj('fio_runs', result['global'])
+        for job in result['jobs']:
+            job['run_id'] = row_id
+            self._insert_obj('fio_jobs', job)
diff --git a/src/perf/fio-insert-and-compare.py b/src/perf/fio-insert-and-compare.py
new file mode 100644
index 000000000000..064af6daaa40
--- /dev/null
+++ b/src/perf/fio-insert-and-compare.py
@@ -0,0 +1,35 @@
+import FioResultDecoder
+import ResultData
+import FioCompare
+import json
+import argparse
+import sys
+import platform
+
+parser = argparse.ArgumentParser()
+parser.add_argument('-c', '--configname', type=str,
+                    help="The config name to save the results under.",
+                    required=True)
+parser.add_argument('-d', '--db', type=str,
+                    help="The db that is being used", required=True)
+parser.add_argument('-n', '--testname', type=str,
+                    help="The testname for the result", required=True)
+parser.add_argument('result', type=str,
+                    help="The result file to compare and insert")
+args = parser.parse_args()
+
+result_data = ResultData.ResultData(args.db)
+compare = result_data.load_last(args.testname, args.configname)
+
+json_data = open(args.result)
+data = json.load(json_data, cls=FioResultDecoder.FioResultDecoder)
+data['global']['name'] = args.testname
+data['global']['config'] = args.configname
+data['global']['kernel'] = platform.release()
+result_data.insert_result(data)
+
+if compare is None:
+    sys.exit(0)
+
+if FioCompare.compare_fiodata(compare, data, False):
+    sys.exit(1)
diff --git a/src/perf/fio-results.sql b/src/perf/fio-results.sql
new file mode 100644
index 000000000000..62e1464834b0
--- /dev/null
+++ b/src/perf/fio-results.sql
@@ -0,0 +1,94 @@
+CREATE TABLE IF NOT EXISTS `fio_runs` (
+  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
+  `kernel` datetime NOT NULL,
+  `config` varchar(256) NOT NULL,
+  `name` varchar(256) NOT NULL,
+  `time` datetime NOT NULL
+);
+CREATE TABLE IF NOT EXISTS `fio_jobs` (
+  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
+  `run_id` int NOT NULL,
+  `read_bw_dev` float,
+  `trim_lat_ns_mean` float,
+  `read_runtime` int,
+  `trim_runtime` int,
+  `read_io_bytes` int,
+  `read_short_ios` int,
+  `write_lat_ns_stddev` float,
+  `minf` int,
+  `read_drop_ios` int,
+  `trim_iops_samples` int,
+  `trim_iops_max` int,
+  `trim_bw_agg` float,
+  `write_bw_min` int,
+  `latency_percentile` float,
+  `read_bw_max` int,
+  `write_bw` int,
+  `read_bw_min` int,
+  `trim_bw_dev` float,
+  `read_iops_max` int,
+  `read_lat_ns_mean` float,
+  `write_iops` float,
+  `latency_target` int,
+  `trim_bw` int,
+  `write_iops_samples` int,
+  `read_bw_samples` int,
+  `trim_io_kbytes` int,
+  `read_iops_samples` int,
+  `write_drop_ios` int,
+  `trim_iops_min` int,
+  `write_bw_samples` int,
+  `read_iops_stddev` float,
+  `write_io_kbytes` int,
+  `groupid` int,
+  `trim_bw_mean` float,
+  `write_bw_agg` float,
+  `write_bw_dev` float,
+  `read_bw` int,
+  `trim_lat_ns_stddev` float,
+  `read_bw_mean` float,
+  `latency_depth` int,
+  `trim_short_ios` int,
+  `read_lat_ns_stddev` float,
+  `read_io_kbytes` int,
+  `latency_window` int,
+  `write_iops_stddev` float,
+  `trim_bw_samples` int,
+  `trim_lat_ns_min` int,
+  `error` int,
+  `trim_iops_mean` float,
+  `elapsed` int,
+  `write_iops_mean` float,
+  `write_bw_mean` float,
+  `write_short_ios` int,
+  `write_io_bytes` int,
+  `usr_cpu` float,
+  `trim_drop_ios` int,
+  `read_iops_min` int,
+  `jobname` varchar(256),
+  `write_iops_min` int,
+  `trim_bw_min` int,
+  `read_bw_agg` float,
+  `trim_lat_ns_max` int,
+  `write_lat_ns_min` int,
+  `read_iops_mean` float,
+  `trim_iops_stddev` float,
+  `write_lat_ns_max` int,
+  `majf` int,
+  `write_total_ios` int,
+  `ctx` int,
+  `read_lat_ns_min` int,
+  `trim_bw_max` int,
+  `read_total_ios` int,
+  `write_runtime` int,
+  `trim_io_bytes` int,
+  `eta` int,
+  `read_iops` float,
+  `trim_total_ios` int,
+  `write_lat_ns_mean` float,
+  `write_iops_max` int,
+  `write_bw_max` int,
+  `sys_cpu` float,
+  `read_lat_ns_max` int,
+  `trim_iops` float
+);
diff --git a/src/perf/generate-schema.py b/src/perf/generate-schema.py
new file mode 100644
index 000000000000..b61504b06efb
--- /dev/null
+++ b/src/perf/generate-schema.py
@@ -0,0 +1,55 @@
+import json
+import argparse
+import FioResultDecoder
+from dateutil.parser import parse
+
+def is_date(string):
+    try:
+        parse(string)
+        return True
+    except ValueError:
+        return False
+
+def print_schema_def(key, value, required):
+    typestr = value.__class__.__name__
+    if typestr == 'str' or typestr == 'unicode':
+        if (is_date(value)):
+            typestr = "datetime"
+        else:
+            typestr = "varchar(256)"
+    requiredstr = ""
+    if required:
+        requiredstr = " NOT NULL"
+    return ",\n  `{}` {}{}".format(key, typestr, requiredstr)
+
+parser = argparse.ArgumentParser()
+parser.add_argument('infile', help="The json file to strip")
+args = parser.parse_args()
+
+json_data = open(args.infile)
+data = json.load(json_data, cls=FioResultDecoder.FioResultDecoder)
+
+# These get populated by the test runner, not fio, so add them so their
+# definitions get populated in the schema properly
+data['global']['config'] = 'default'
+data['global']['kernel'] = '4.14'
+data['global']['name'] = 'alrightalrightalright'
+
+print("CREATE TABLE IF NOT EXISTS `fio_runs` (")
+outstr = "  `id` INTEGER PRIMARY KEY AUTOINCREMENT"
+for key,value in data['global'].iteritems():
+    outstr += print_schema_def(key, value, True)
+print(outstr)
+print(");")
+
+required_fields = ['run_id']
+
+job = data['jobs'][0]
+job['run_id'] = 0
+
+print("CREATE TABLE IF NOT EXISTS `fio_jobs` (")
+outstr = "  `id` INTEGER PRIMARY KEY AUTOINCREMENT"
+for key,value in job.iteritems():
+    outstr += print_schema_def(key, value, key in required_fields)
+print(outstr)
+print(");")
-- 
2.7.4

