Received: from mx1.redhat.com ([209.132.183.28]:43356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757364AbdIIKWF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 9 Sep 2017 06:22:05 -0400
Date: Sat, 9 Sep 2017 18:22:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 1/8] log-writes: add replay-log program to replay
 dm-log-writes target
Message-ID: <20170909102202.GV8034@eguan.usersys.redhat.com>
References: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
 <1504778593-12071-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504778593-12071-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 07, 2017 at 01:03:06PM +0300, Amir Goldstein wrote:
> Imported Josef Bacik's code from:
> https://github.com/josefbacik/log-writes.git
> 
> Specialized program for replaying a write log that was recorded by
> device mapper log-writes target.  The tools is used to perform
> crash consistency tests, allowing to run an arbitrary check tool
> (fsck) at specified checkpoints in the write log.
> 
> [Amir:]
> - Add project Makefile and SOURCE files
> - Document the replay-log auxiliary program
> - Address review comments by Eryu Guan
> 
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
...
> diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
> new file mode 100644
> index 0000000..6cadb66
> --- /dev/null
> +++ b/src/log-writes/log-writes.h
> @@ -0,0 +1,77 @@
> +#ifndef _LOG_WRITES_H_
> +#define _LOG_WRITES_H_
> +
> +#include <linux/types.h>
> +#include <linux/byteorder/little_endian.h>

This only works on little endian hosts, big endian hosts like ppc64 fail
the tests with "Magic doesn't match" error, because le64_to_cpu is an
no-op there.

I did the following changes and it worked for me. If this looks fine to
you, I can fold the changes into the original patch.

--- 8< ---
diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
index 14242ee13c6b..0fb324a57c4d 100644
--- a/src/log-writes/log-writes.h
+++ b/src/log-writes/log-writes.h
@@ -2,7 +2,12 @@
 #define _LOG_WRITES_H_

 #include <linux/types.h>
-#include <linux/byteorder/little_endian.h>
+#include <endian.h>
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#include <linux/byteorder/little_endian.h>
+#else
+#include <linux/byteorder/big_endian.h>
+#endif

 extern int log_writes_verbose;

--- >8 ---
Thanks,
Eryu
