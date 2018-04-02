Received: from mail-pl0-f67.google.com ([209.85.160.67]:40781 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeDBRPB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Apr 2018 13:15:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id x4-v6so4930494pln.7
        for <fstests@vger.kernel.org>; Mon, 02 Apr 2018 10:15:01 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] test-appliance: fix use of undefined variable in gen_results_summary
Date: Mon,  2 Apr 2018 10:14:13 -0700
Message-Id: <20180402171413.63324-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

This fixes the following Python error when no tests were run:

    Traceback (most recent call last):
      File "/usr/local/bin/gen_results_summary", line 22, in <module>
	main()
      File "/usr/local/bin/gen_results_summary", line 19, in main
	sys.exit('No results file found in ' + results_dir)
    NameError: global name 'results_dir' is not defined

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/files/usr/local/bin/gen_results_summary      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/usr/local/bin/gen_results_summary b/kvm-xfstests/test-appliance/files/usr/local/bin/gen_results_summary
index be4401e..57c4a08 100755
--- a/kvm-xfstests/test-appliance/files/usr/local/bin/gen_results_summary
+++ b/kvm-xfstests/test-appliance/files/usr/local/bin/gen_results_summary
@@ -16,7 +16,7 @@ def main():
 
     if gen_results_summary(args.results_dir, args.output_file,
                            args.merge_file, args.verbose) == 0:
-        sys.exit('No results file found in ' + results_dir)
+        sys.exit('No results file found in ' + args.results_dir)
 
 if __name__ == "__main__":
     main()
-- 
2.17.0.rc1.321.gba9d0f2565-goog

