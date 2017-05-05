Received: from userp1040.oracle.com ([156.151.31.81]:32006 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdEEFVT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 May 2017 01:21:19 -0400
Date: Thu, 4 May 2017 22:21:10 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH V3] punch-alternating: add some options
Message-ID: <20170505052110.GC5970@birch.djwong.org>
References: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
 <1a55a8a0-00dd-bb73-c888-5c1a889c7302@sandeen.net>
 <0768eacb-b76f-3a4b-e05a-bc39dde343b4@sandeen.net>
 <20170505043234.GQ7250@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505043234.GQ7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, May 05, 2017 at 12:32:34PM +0800, Eryu Guan wrote:
> On Thu, May 04, 2017 at 01:25:05PM -0500, Eric Sandeen wrote:
> > I didn't end up using this, but somebody else might find
> > it useful, so sending it.
> > 
> > This change lets us specify punch patterns other than
> > literally every other block.
> > 
> > i.e. punch-alternating with no options will do:
> > 
> > ...HDHDHDHDHDHD...
> > 
> > -i 4 -s 2 will do:
> > 
> > ...DDHHDDHHDDHH...
> > 
> > or -i 3 -s 1 will do:
> > 
> > ...DDHDDHDDHDDH...
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > V2: don't allow interval of zero, or extra arguments
> >     other than the filename after the parsed options.
> > 
> > V3: Ok, don't allow negative intervals or sizes, either.
> > 
> > 
> > 
> > diff --git a/src/punch-alternating.c b/src/punch-alternating.c
> > index 4148622..11aa65c 100644
> > --- a/src/punch-alternating.c
> > +++ b/src/punch-alternating.c
> > @@ -11,6 +11,14 @@
> >  #include <string.h>
> >  #include "global.h"
> >  
> > +void usage(char *cmd)
> > +{
> > +	printf("Usage: %s [-i interval] [-s size] file\n", cmd);
> > +	printf("Punches every other block in the file by default,\n");
> > +	printf("or 'size' blocks every 'interval' blocks with options.\n");
> > +	exit(1);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >  	struct stat	s;
> > @@ -21,14 +29,37 @@ int main(int argc, char *argv[])
> >  	off_t		sz;
> >  	int		mode;
> >  	int		error;
> > +	int		c;
> > +	int		size = 1;	/* punch $SIZE blocks ... */
> > +	int		interval = 2;	/* every $INTERVAL blocks */
> > +
> > +	while ((c = getopt(argc, argv, "i:s:")) != EOF) {
> > +		switch (c) {
> > +		case 'i':
> > +			interval = atoi(optarg);
> > +			break;
> > +		case 's':
> > +			size = atoi(optarg);
> > +			break;
> > +		default:
> > +			usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (interval <= 0) {
> > +		printf("interval must be > 0\n");
> > +		usage(argv[0]);
> > +	}
> >  
> > -	if (argc != 2) {
> > -		printf("Usage: %s file\n", argv[0]);
> > -		printf("Punches every other block in the file.\n");
> > -		return 1;
> > +	if (size < 0) {
> > +		printf("size must be >= 0\n");
> > +		usage(argv[0]);
> 
> Can size be 0? Seems not, otherwise we call fallocate with zero length.
> I got this error if I use "-s 0"
> 
> $ ./src/punch-alternating -s 0 -i 8 testfile
> -s: Invalid argument

LOL!

The "perror(argv[1])" in the error clause needs to be updated too.

--D

> And the "-s" part indicates that the perror call in 'err' label should
> be updated too, i.e. argv[1] => argv[optind]
> 
> They're simple enough to be fixed at commit time, if you think they're
> sane fixes :)
> 
> Thanks,
> Eryu
> 
> >  	}
> >  
> > -	fd = open(argv[1], O_WRONLY);
> > +	if (optind != argc - 1)
> > +		usage(argv[0]);
> > +
> > +	fd = open(argv[optind], O_WRONLY);
> >  	if (fd < 0)
> >  		goto err;
> >  
> > @@ -44,8 +75,8 @@ int main(int argc, char *argv[])
> >  	blksz = sf.f_bsize;
> >  
> >  	mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > -	for (offset = 0; offset < sz; offset += blksz * 2) {
> > -		error = fallocate(fd, mode, offset, blksz);
> > +	for (offset = 0; offset < sz; offset += blksz * interval) {
> > +		error = fallocate(fd, mode, offset, blksz * size);
> >  		if (error)
> >  			goto err;
> >  	}
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
