FROM test/s2i-php-container

# This image provides an Apache+PHP environment for running PHP
# applications.

EXPOSE 8080



LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Apache 2.4 with PHP 7.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,php,php70,rh-php70" \
      name="centos/php-70-centos7" \
      com.redhat.component="rh-php70-docker" \
      version="7.0" \
      release="1" \
      maintainer="SoftwareCollections.org <sclorg@redhat.com>"



# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH

# Copy extra files to the image.

# In order to drop the root user, we have to make some directories world
# writeable as OpenShift default security model is to run the container under
# random UID.




USER 1001

# Install Drupal tools: Robo, Drush, Drupal console and Composer.
RUN wget -O /usr/local/bin/robo https://github.com/consolidation/Robo/releases/download/1.0.4/robo.phar && chmod +x /usr/local/bin/robo \
&& wget -O /usr/local/bin/drush https://s3.amazonaws.com/files.drush.org/drush.phar && chmod +x /usr/local/bin/drush \
&& wget -O /usr/local/bin/drupal https://drupalconsole.com/installer && chmod +x /usr/local/bin/drupal && /usr/local/bin/drupal init \
&& wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/local/bin --filename=composer

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
