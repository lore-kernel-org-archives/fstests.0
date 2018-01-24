Received: from mx1.redhat.com ([209.132.183.28]:40662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbeAXEA6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jan 2018 23:00:58 -0500
Date: Wed, 24 Jan 2018 12:00:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 5/8] dmiperf: Include sys/types.h for u_int32_t
Message-ID: <20180124040056.GB30514@eguan.usersys.redhat.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-6-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-6-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:16PM +0000, Rostislav Skudnov wrote:
> u_int32_t type is defined in sys/types.h, which is often included by
> glibc implicitly when some other headers are used, but other C libraries
> such as musl may not necessarily do so, therefore an explicit include is
> needed.
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Hmm, no one is using dmiperf either, remove it too?

Thanks,
Eryu

> ---
>  src/dmiperf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/dmiperf.c b/src/dmiperf.c
> index 245e529..359324a 100644
> --- a/src/dmiperf.c
> +++ b/src/dmiperf.c
> @@ -16,6 +16,7 @@
>   * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  
> +#include <sys/types.h>
>  #include <sys/param.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
