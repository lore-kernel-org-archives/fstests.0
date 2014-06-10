Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44705 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaFJFVf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 10 Jun 2014 01:21:35 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so5720144pdb.17
        for <fstests@vger.kernel.org>; Mon, 09 Jun 2014 22:21:35 -0700 (PDT)
Date: Tue, 10 Jun 2014 13:21:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: new case to test getcwd(2)
Message-ID: <20140610052130.GA6210@dhcp-13-216.nay.redhat.com>
References: <1402313873-9983-1-git-send-email-eguan@redhat.com>
 <20140610010254.GG4453@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140610010254.GG4453@dastard>
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, Artem Savkov <asavkov@redhat.com>, Jan Stancek <jstancek@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 10, 2014 at 11:02:54AM +1000, Dave Chinner wrote:
> On Mon, Jun 09, 2014 at 07:37:53PM +0800, Eryu Guan wrote:
> > getcwd(2) may return "/" instead of the correct cwd on buggy kernel.
> 
> What buggy kernel are we talking about here? In what conditions may
> that bug happen?

I tested it on RHEL7 Beta kernel and test failed. It returns "/"
randomly, Jan Stancek hit it once when building ltp and Mikulas
Patocka could hit it by running lvm2 test suite. Please refer to this
thread

https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg17896.html

I'll put more details in commit log.
> 
> 
> > Regression test for:
> > ede4ceb prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
> > f650080 __dentry_path() fixes
> 
> Al's commits don't tell you anything about the context of the bug
> being fixed...
> 
> ....
> > diff --git a/src/t_getcwd.c b/src/t_getcwd.c
> > new file mode 100644
> > index 0000000..891de75
> > --- /dev/null
> > +++ b/src/t_getcwd.c
> > @@ -0,0 +1,90 @@
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#define TIMEOUT 60
> 
> Does it need to run for 60 seconds? If we keep adding tests that run
> one timeouts measured in minutes, we're going to blow out the
> runtime of the test suite to being unmanageable pretty quickly.

The problem shows up pretty quickly, I think 10s is long enough. I'll
reduce the run time.

> 
> > +#define BUF_SIZE 256
> > +
> > +static sig_atomic_t end;
> > +
> > +void test_getcwd(char *init_cwd)
> > +{
> > +	int i = 0;
> > +	char cur_cwd[BUF_SIZE];
> > +	while (!end) {
> > +		getcwd(cur_cwd, BUF_SIZE);
> > +		if (strncmp(init_cwd, cur_cwd, BUF_SIZE)) {
> > +			printf("[%u] %s != %s\n", i, init_cwd, cur_cwd);
> > +			break;
> > +		}
> > +		i++;
> > +	}
> > +}
> 
> So this runs in a tight loop checking if it's working dir
> changes? This should return an error if the $CWD changes...

OK

> 
> > +void do_rename(char *prefix)
> > +{
> > +	int i = 0;
> > +	int fd;
> > +	char c_name[BUF_SIZE];
> > +	char n_name[BUF_SIZE];
> > +
> > +	strncpy(c_name, prefix, BUF_SIZE);
> > +
> > +	fd = open(c_name, O_CREAT | O_RDWR);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "failed to create file %s: %s\n",
> > +			c_name, strerror(errno));
> > +		exit(1);
> > +	}
> > +	close(fd);
> > +
> > +	while (1) {
> > +		i++;
> > +		snprintf(n_name, BUF_SIZE, "%s%u", prefix, i);
> > +		rename(c_name, n_name);
> > +		strncpy(c_name, n_name, BUF_SIZE);
> > +	}
> > +}
> 
> And the child process sits in a tight loop renaming a file in $CWD
> until it is killed?
> 
> > +void sigproc(int sig)
> > +{
> > +	end = 1;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	char init_cwd[BUF_SIZE];
> > +	pid_t pid;
> > +	int status;
> > +	int ret = 1;
> > +
> > +	getcwd(init_cwd, BUF_SIZE);
> > +
> > +	if (signal(SIGALRM, sigproc) == SIG_ERR) {
> > +		perror("signal failed");
> > +		exit(1);
> > +	}
> > +
> > +	alarm(TIMEOUT);
> > +
> > +	pid = fork();
> > +	if (pid < 0) {
> > +		perror("fork failed");
> > +		exit(1);
> > +	} else if (pid == 0) {
> > +		do_rename("testfile");
> > +	} else {
> > +		test_getcwd(init_cwd);
> > +		ret = !end;
> 
> 		ret = test_getcwd(init_cwd);
> 
> > +		kill(pid, SIGTERM);
> > +		waitpid(pid, &status, 0);
> > +	}
> > +
> > +	exit(ret);
> > +}
> > diff --git a/tests/generic/028 b/tests/generic/028
> > new file mode 100755
> > index 0000000..12216df
> > --- /dev/null
> > +++ b/tests/generic/028
> > @@ -0,0 +1,54 @@
> > +#! /bin/bash
> > +# FS QA Test No. generic/028
> > +#
> > +# Regression test for
> > +# ede4ceb prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
> > +# f650080 __dentry_path() fixes
> 
> Needs a better description.

OK.

> 
> > +
> > +rm -f $seqres.full
> 
> $seqres.full is not used by the test, so no need to remove it.

OK.

> 
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -30,6 +30,7 @@
> >  025 auto quick
> >  026 acl quick auto
> >  027 auto enospc
> > +028 auto
> 
> If this test doesn't need to run for 60s, then it could also be a
> quick test...

Sure, I'll make it 10s and add quick group.

Thanks for the review!

Eryu
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
