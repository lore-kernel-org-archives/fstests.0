Received: from mx1.redhat.com ([209.132.183.28]:52396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbdJXDXt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Oct 2017 23:23:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC98B85543
        for <fstests@vger.kernel.org>; Tue, 24 Oct 2017 03:23:49 +0000 (UTC)
Date: Tue, 24 Oct 2017 11:23:48 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] ltp/fsstress: check mkdir(2) return value
Message-ID: <20171024032348.uwkbd7i362btvvbp@XZHOUW.usersys.redhat.com>
References: <1507964837-10820-1-git-send-email-xzhou@redhat.com>
 <20171022112606.GA3235@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171022112606.GA3235@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 22, 2017 at 07:26:06PM +0800, Eryu Guan wrote:
> On Sat, Oct 14, 2017 at 03:07:17PM +0800, Xiong Zhou wrote:
> > If mkdir(2) fails, the following chdir(2) would fail either.
> > Although dirname and error message are printed, we don't know
> > which operation has failed.
> > 
> > Like this:
> > +/test2/fsstress.1582: No such file or directory
> > 
> > This trivial fix will check the return value and print detail
> > error info if fail.
> > 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  ltp/fsstress.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 96f48b1..1962d14 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -493,7 +493,11 @@ int main(int argc, char **argv)
> >              exit(1);
> >          }
> >  
> > -	(void)mkdir(dirname, 0777);
> > +	if (mkdir((const char *)dirname, 0777) < 0) {
> > +		fprintf(stderr, "mkdir %s failed: %s\n", dirname,
> > +			strerror(errno));
> > +		exit(1);
> > +	}
> 
> This changed current fsstress behavior and made some tests fail, e.g.
> generic/013, because fsstress exited with EEXIST if there was a
> pre-created test dir. e.g.
> 
> mkdir /mnt/test/fsstress
> ./ltp/fsstress -d /mnt/test/fsstress -n 10 -p 10 -v
> mkdir /mnt/test/fsstress failed: File exists

hmm.. Please forget this thread.

Thanks,
Xiong
> 
> >  	if (logname && logname[0] != '/') {
> >  		if (getcwd(rpath, sizeof(rpath)) < 0){
> >  			perror("getcwd failed");
> > @@ -503,7 +507,8 @@ int main(int argc, char **argv)
> >  		rpath[0] = '\0';
> >  	}
> >  	if (chdir(dirname) < 0) {
> > -		perror(dirname);
> > +		fprintf(stderr, "chdir %s failed: %s\n", dirname,
> > +			strerror(errno));
> >  		exit(1);
> >  	}
> >  	if (logname) {
> > @@ -959,7 +964,11 @@ doproc(void)
> >  
> >  	dividend = (operations + execute_freq) / (execute_freq + 1);
> >  	sprintf(buf, "p%x", procid);
> > -	(void)mkdir(buf, 0777);
> > +	if (mkdir((const char *)buf, 0777) < 0) {
> > +		fprintf(stderr, "mkdir %s failed: %s\n", buf,
> > +			strerror(errno));
> > +		exit(1);
> > +	}
> 
> Same here.
> 
> Thanks,
> Eryu
> 
> >  	if (chdir(buf) < 0 || stat64(".", &statbuf) < 0) {
> >  		perror(buf);
> >  		_exit(1);
> > -- 
> > 1.8.3.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
