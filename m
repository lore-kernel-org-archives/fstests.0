Received: from mx1.redhat.com ([209.132.183.28]:44058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbdJVL0J (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 22 Oct 2017 07:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA6E0C049D49
        for <fstests@vger.kernel.org>; Sun, 22 Oct 2017 11:26:08 +0000 (UTC)
Date: Sun, 22 Oct 2017 19:26:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ltp/fsstress: check mkdir(2) return value
Message-ID: <20171022112606.GA3235@eguan.usersys.redhat.com>
References: <1507964837-10820-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507964837-10820-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 14, 2017 at 03:07:17PM +0800, Xiong Zhou wrote:
> If mkdir(2) fails, the following chdir(2) would fail either.
> Although dirname and error message are printed, we don't know
> which operation has failed.
> 
> Like this:
> +/test2/fsstress.1582: No such file or directory
> 
> This trivial fix will check the return value and print detail
> error info if fail.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  ltp/fsstress.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 96f48b1..1962d14 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -493,7 +493,11 @@ int main(int argc, char **argv)
>              exit(1);
>          }
>  
> -	(void)mkdir(dirname, 0777);
> +	if (mkdir((const char *)dirname, 0777) < 0) {
> +		fprintf(stderr, "mkdir %s failed: %s\n", dirname,
> +			strerror(errno));
> +		exit(1);
> +	}

This changed current fsstress behavior and made some tests fail, e.g.
generic/013, because fsstress exited with EEXIST if there was a
pre-created test dir. e.g.

mkdir /mnt/test/fsstress
./ltp/fsstress -d /mnt/test/fsstress -n 10 -p 10 -v
mkdir /mnt/test/fsstress failed: File exists

>  	if (logname && logname[0] != '/') {
>  		if (getcwd(rpath, sizeof(rpath)) < 0){
>  			perror("getcwd failed");
> @@ -503,7 +507,8 @@ int main(int argc, char **argv)
>  		rpath[0] = '\0';
>  	}
>  	if (chdir(dirname) < 0) {
> -		perror(dirname);
> +		fprintf(stderr, "chdir %s failed: %s\n", dirname,
> +			strerror(errno));
>  		exit(1);
>  	}
>  	if (logname) {
> @@ -959,7 +964,11 @@ doproc(void)
>  
>  	dividend = (operations + execute_freq) / (execute_freq + 1);
>  	sprintf(buf, "p%x", procid);
> -	(void)mkdir(buf, 0777);
> +	if (mkdir((const char *)buf, 0777) < 0) {
> +		fprintf(stderr, "mkdir %s failed: %s\n", buf,
> +			strerror(errno));
> +		exit(1);
> +	}

Same here.

Thanks,
Eryu

>  	if (chdir(buf) < 0 || stat64(".", &statbuf) < 0) {
>  		perror(buf);
>  		_exit(1);
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
