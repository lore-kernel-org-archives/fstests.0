Received: from mx2.suse.de ([195.135.220.15]:51350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730887AbfHHH3o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Aug 2019 03:29:44 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A48C7AB7D
        for <fstests@vger.kernel.org>; Thu,  8 Aug 2019 07:29:43 +0000 (UTC)
From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] fstests: log-writes: Handle unrecognized options to prevent segfault
Date: Thu,  8 Aug 2019 15:29:40 +0800
Message-Id: <20190808072940.18684-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[BUG]
When using --help parameter (unrecognized) after valid --log/--replay,
log-writes just crashes:
  Starting program: replay-log --log /dev/test/test  --replay /dev/test/scratch1 --help
  /home/adam/xfstests-dev/src/log-writes/replay-log: unrecognized option '--help'

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7f5cc55 in __strlen_avx2 () from /usr/lib/libc.so.6
  (gdb) bt
  #0  0x00007ffff7f5cc55 in __strlen_avx2 () from /usr/lib/libc.so.6
  #1  0x00007ffff7e89363 in strdup () from /usr/lib/libc.so.6
  #2  0x00005555555554ac in main (argc=6, argv=0x7fffffffea78)
      at replay-log.c:219

[CAUSE]
We didn't check return value from getopt_long() for unrecognized
parameter, thus we reuse the old opt_index, and if that option needs an
parameter, we will access optarg which can be NULL and cause segfault.

[FIX]
Check return value from getopt_long() for '?' to handle unrecognized
options correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 src/log-writes/replay-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
index c16df40e..829b18e2 100644
--- a/src/log-writes/replay-log.c
+++ b/src/log-writes/replay-log.c
@@ -162,6 +162,8 @@ int main(int argc, char **argv)
 		case 'v':
 			log_writes_verbose++;
 			continue;
+		case '?':
+			usage();
 		default:
 			break;
 		}
-- 
2.22.0
