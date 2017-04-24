Received: from mga02.intel.com ([134.134.136.20]:54499 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S974728AbdDXQef (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Apr 2017 12:34:35 -0400
Date: Mon, 24 Apr 2017 10:34:27 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 4/4] generic: mmap write readonly DAX file
Message-ID: <20170424163427.GA21854@linux.intel.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-5-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492413255-11146-5-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 03:14:15PM +0800, Xiong Zhou wrote:
> Regression case that one can write to read-only
> file in a DAX mountpoint.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
<>
> diff --git a/src/t_mmap_write_ro.c b/src/t_mmap_write_ro.c
> new file mode 100644
> index 0000000..08ec1d0
> --- /dev/null
> +++ b/src/t_mmap_write_ro.c
> @@ -0,0 +1,77 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <libgen.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +void
> +err_exit(char *op)
> +{
> +	fprintf(stderr, "%s: %s\n", op, strerror(errno));
> +	exit(1);
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	int fd, pfd, ret;
> +	char *buf;
> +	/* gcc -O2 will optimize foo's storage, preventing
> +	 * reproduce this issue.
> +	 * foo is never actually used after fault in value stored.
> +	 */
> +	volatile char foo __attribute__((__unused__));
> +	int pagesize = getpagesize();
> +
> +	if (argc < 2) {
> +		printf("Usage: %s <file> <pmem file>\n", basename(argv[0]));

This comparison should be:
+	if (argc < 3) {

$ ./src/t_mmap_write_ro 
Usage: t_mmap_write_ro <file> <pmem file>
$ ./src/t_mmap_write_ro a
open: No such file or directory
