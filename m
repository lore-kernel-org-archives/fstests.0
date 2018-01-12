Received: from mail.cn.fujitsu.com ([183.91.158.132]:19033 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbeALGTi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Jan 2018 01:19:38 -0500
Message-ID: <5A585378.70900@cn.fujitsu.com>
Date: Fri, 12 Jan 2018 14:19:36 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] syscalls/madvise09.c: Use custom mount point instead
 of /sys/fs/cgroup/memory
References: <20180111180734.GD1168@magnolia> <1515737662-1993-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1515737662-1993-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Hi,

Sorry, please ignore the wrong patchset, i will resend the v2 patchset.

Thanks,
Xiao Yang
On 2018/01/12 14:14, xiao yang wrote:
> 1) on some distros(e.g. RHEL6), memory cgroup was supported and
>    mounted on /cgroup/memory by default, but the test was skipped
>    if /sys/fs/cgroup/memory did not exist.
>
> 2) We got the following error if memory cgroup wasn't mounted
>    on /sys/fs/cgroup/memory:
>    ------------------------------------------------------------
>    safe_macros.c:169: BROK: madvise09.c:175: mkdir(/sys/fs/cgroup/memory/ltp_madvise09_16386/,0777) failed: EROFS
>    ------------------------------------------------------------
>
> We use custom mount point and mount memory cgroup on it manually
> to fix these issues.
>
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/madvise/madvise09.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
> index f744405..25cf81f 100644
> --- a/testcases/kernel/syscalls/madvise/madvise09.c
> +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> @@ -53,12 +53,14 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <ctype.h>
> +#include <sys/mount.h>
>  
>  #include "tst_test.h"
>  #include "lapi/mmap.h"
>  
> -#define MEMCG_PATH "/sys/fs/cgroup/memory/"
> +#define MEMCG_PATH "/dev/memcg_madvise09/"
>  
> +static int memcg_mounted;
>  static char cgroup_path[PATH_MAX];
>  static char tasks_path[PATH_MAX];
>  static char limit_in_bytes_path[PATH_MAX];
> @@ -277,6 +279,15 @@ static void cleanup(void)
>  {
>  	if (cgroup_path[0] && !access(cgroup_path, F_OK))
>  		rmdir(cgroup_path);
> +
> +	if (memcg_mounted) {
> +		tst_res(TINFO, "Umount memory cgroup after testing");
> +		SAFE_UMOUNT(MEMCG_PATH);
> +		memcg_mounted = 0;
> +	}
> +
> +	if (!access(MEMCG_PATH, F_OK) && rmdir(MEMCG_PATH))
> +		tst_res(TWARN | TERRNO, "Rmdir %s failed", MEMCG_PATH);
>  }
>  
>  static void run(void)
> @@ -316,10 +327,17 @@ static void setup(void)
>  {
>  	long int swap_total;
>  
> -	if (access(MEMCG_PATH, F_OK)) {
> -		tst_brk(TCONF, "'" MEMCG_PATH
> -			"' not present, CONFIG_MEMCG missing?");
> +	SAFE_MKDIR(MEMCG_PATH, 0777);
> +
> +	tst_res(TINFO, "Mount memory cgroup on %s", MEMCG_PATH);
> +	if (mount("memcg", MEMCG_PATH, "cgroup", 0, "memory") == -1) {
> +		if (errno == ENODEV) {
> +			tst_brk(TCONF,
> +				 "Memory cgroup was not configured in kernel");
> +		}
> +		tst_brk(TBROK | TERRNO, "Failed to mount memory cgroup");
>  	}
> +	memcg_mounted = 1;
>  
>  	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
>  		swap_accounting_enabled = 1;



